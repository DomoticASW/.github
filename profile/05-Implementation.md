# Implementation

## Tools

In order to achieve higher software quality and reliability we decided to opt for the following optional tools:

- Typescript (both on the server and the client)
- functional programming library Effect-TS (on the server)
- Tailwind CSS (on the client)
- DaisyUI components library for Tailwind (on the client)

## Devices management

### Protocol

It is required that every device while requesting an ip from the LAN DHCP server will also specify a name to bind to that ip.
This allows the server to store this name and use it to reach devices even if they change their ip.

#### Devices discovery

Devices announce themselves on a configurable known port by sending broadcast UDP datagrams including basic data (id, name, lan hostname and port) that can be used by the server to register them to the system.
The server [DeviceDiscovererUDPAdapter.ts](https://github.com/DomoticASW/server/blob/main/src/adapters/devices-management/DeviceDiscovererUDPAdapter.ts) will keep device announces in memory for a finite amount of time before forgetting them.

#### DeviceCommunicationProtocol

The communication protocols expects devices to expose the following http routes on the port that he announced during discovery:

- **POST /register**

  The server will contact the discovered device at this route providing the server port that the device will use to communicate with it afterwards.

  The device will respond with a json description of himself (look at [DeviceCommunicationProtocolHttpAdapter.ts](https://github.com/DomoticASW/server/blob/main/src/adapters/devices-management/DeviceCommunicationProtocolHttpAdapter.ts) inline doc for more info).

  From now on the device is registered to the system and is enabled to send updates about its properties to the server.

- **POST /unregister**

  The server informs the device that it has been removed from the system.

- **POST /execute/<deviceActionId>**

  The server tells the device to execute a specific action given some input.

- **GET /check-status**

  The server will periodically ask the device if it is healthy (any 2xx status code will indicate healthiness).

### Real time property updates

The DevicesService allows to subscribe for receiving device property updates.
One of these subscribers is [SocketIOPropertyUpdatesSubscriberAdapter.ts](https://github.com/DomoticASW/server/blob/main/src/adapters/devices-management/SocketIOPropertyUpdatesSubscriberAdapter.ts) which is a SocketIO
server that will will relay the updates to every client that connects to it.

### Repositories

All repositories of this bounded context are implemented by extending a generic implementation (look at [BaseRepositoryMongoAdapter.ts](https://github.com/DomoticASW/server/blob/main/src/adapters/BaseRepositoryMongoAdapter.ts) for more infos)

### Http API

Each service has its own http controller which defines routes and http logic (you can look at [http adapters](https://github.com/DomoticASW/server/blob/main/src/adapters/http/routes/devices-management)).

DTOs are used when the interface to be exposed has to be different from the internal interface
of entities. (This is done only due to time constraints, in an ideal scenario it would be better to define DTOs for each entity)

## Notifications Management

The **NotificationProtocol** exposes a **SocketIO** endpoint to which the client can then connect in order to receive the notifications sent by the server (**DeviceOfflineNotifications** or other kind of notifications, like the one sent from the *script instructions*).

To receive a notification a user must first emits the event "*login*" sending its email, then the server will send an event "*notification*" to that user when needed (based on **DeviceOfflineNotificationSubscriptions**, script instructions or script error), sending a message.

## Scripts Management

### Script

According to the modelling of the **Script** aggregate, it is an interface that allows users to execute instructions.

**Task** and **Automation** extends the **Script** interface in order to have the behaviour described in the modelling part.

When executed, a Script creates an **ExecutionEnvironment** for that execution (because a script can be started while it is already started, it will create another, fresh one, ExecutionEnvironment every time it is started).

If a **Script** returns an error after being executed, a notification will be sent to the admin.

### Instructions

There are multiple instructions, some which just do some action like waiting, starting other tasks, creating costants, sending a notification or executing device actions, others control the flow of the script, like if or if-else.

- **WaitInstruction**: Stop the script for a specified amount of seconds.
- **SendNotificationInstruction**: Send a notification through the NotificationService to a specified email with a specified message.
- **StartTaskInstruction**: Start another task with the same permissions of the one who started the current task.
- **DeviceActionInstruction**: Execute a specified action on a chosen device.
- **CreateConstantInstruction**: Create a named constant with a value of the specified type.
- **CreateDevicePropertyConstantInstruction**: Create a named constant with a device and a property of that device. At runtime, it will have the value of the specified property.
- **IfInstruction**: Check if it is valid a _Condition_, if it is true than execute the instructions in the **then** field.
  -- **IfElseInstruction**: Check if it is valid a _Condition_, if it is true than execute the instructions in the **then** field, otherwise execute the instructions in the **else** field.

### Condition

A **Condition** is a data structure which contains two *ConstantInstruction*s, a _negate_ field and a **ConditionOperator**.

It has also an _evaluate(ExecutionEnvironment)_ method, which returns a boolean based on the _ConditionOperator_, the two *ConstantInstruction*s and the _negate_ field, which, if it is true, switch the boolean returned by the _evaluate_ method (if negate = true and negate should return true, than evaluate returns false)

To be created, the two *ConstantInstruction*s and the _ConditionOperator_ must have the same type.

### ConditionOperator

There are multiple **ConditionOperator**s:

- **NumberEOperator**: Equal operator for numbers.
- **NumberGEOperator**: Greater equal operator for numbers.
- **NumberGOperator**: Greater operator for numbers.
- **NumberLEOperator**: Less equal operator for numbers.
- **NumberLOperator**: Less operator for numbers.
- **StringEOperator**: Equal operator for strings.
- **ColorEOperator**: Equal operator for colors.
- **BooleanEOperator**: Equal operator for booleans.

The _evaluate_ method of the _ConditionOperator_ gets two arguments, the left and right constants, in order to evaluate if the operator returns true or false.

### ExecutionEnvironment

At runtime there is the need to have a data structure that saves all the constants with their respective values, and that is the ExecutionEnvironment (indeed, it is here that the _createDevicePropertyConstantInstruction_ will save its value at runtime).

It is also the data structure which contain the token of the user executing the task, if there is one.

### NodeRef

In order to check the syntax of a script, **NodeRef**s are used, which are a data structure that just contains its **superNode**, which is another _NodeRef_.

There can be 3 types of *NodeRef*s:

- **RootNodeRef**: The node which refers to the root of the script, its super node is itself
- **ThenNodeRef**: The node which refers to an instruction inside the **then** part of an if or if-else. The superNode is the node in which is contained the if. Additionaly to the superNode, it has a reference to the **If/IfElseInstruction** in which it is contained.
- **ElseNodeRef**: The node which refers to an instruction inside the **else** part of an if-else. The superNode is the node in which is contained the if-else. Additionaly to the superNode, it has a reference to the **IfElseInstruction** in which it is contained.

The instruction contained in the _ThenNodeRef_ and in the _ElseNodeRef_ is used when creating the script in order to know for each instruction in which If/IfElseInstruction put it.

### ConstantRef

Other than nodeRefs, it is needed the use of another data structure, called **ConstantRef**. It contains a **ConstantInstruction** and the nodeRef in which the constant has been defined. This is usefull for the following reasons:

- It is possible to check if a constant is declared inside an accessible scope when trying to use it (just like in a programming language)
- It is possibile to know if a constant is declared multiple times inside a scope

In both cases a syntax error is returned.

### ScriptBuilder

According to the modelling of the **ScriptBuilder**, it is an abstract class with methods that create a script checking its syntax.

#### Build

There are two methods to create a script, both used only by the ScriptsService: **build()** and **buildWithId(ScriptID)**.
The _build()_ method will create a script with a random ScriptID, while the _buildWithId(ScriptID)_ will create a script with a given ScriptID.

Both methods return a _InvalidScriptError_ if the syntax of the script is wrong, if the name of the script is empty or if the period trigger of an automation have a zero or negative period.

#### AddInstructions

Every _add[Instruction]_ method get a nodeRef and return the new scriptBuilder, which is the same of the one used but with the new instruction and the new InvalidScriptErrors, if there are some.

E.g.

```typescript
// Creation of task builder
const builderAndRef = new TaskBuilder("taskName");
const builder = builderAndRef[0];
const rootNodeRef = builderAndRef[1];

// Adding wait instruction
const newBuilder = builder.addWait(rootNodeRef, 10);
// *newBuilder* has a wait instruction with 10 seconds on the root of the script,
// while *builder* is still empty
```

There are also some _add[Instruction]_ that returns other data structure besides the new builder:

- **addIf**: Returns a **ThenNodeRef** with the newly created **IfInstruction** inside of it, so that it can be used to add instructions inside the then scope of that if
- **addIfElse**: Returns a **ThenNodeRef** like the _addIf_ and a **ElseNodeRef**, both with the newly created **IfElseInstruction** inside of them, so that it can be used to add instructions inside the else scope of that if else.
- **addCreateConstant**: Returns a **ConstantRef** with the newly created ConstantInstruction ised of it, so that it can be used to create ifs or if-elses
- **addCreateDevicePropertyContant**: Works just like the _addCreateContant_ method.

E.g.

```typescript
// Creation of task builder
const builderAndRef = new TaskBuilder("taskName");
const builder = builderAndRef[0];
const rootNodeRef = builderAndRef[1];

// Adding an integer constant with value 10
const newBuilderAndCRef1 = builder.addCreateConstant(
  rootNodeRef,
  "C1",
  Type.IntType,
  10
);
const c1 = newBuilderAndCRef1[1];
const newBuilder1 = newBuilderAndCRef1[0];

// Adding an integer constant with value 15
const newBuilderAndCRef2 = newBuilder1.addCreateConstant(
  rootNodeRef,
  "C2",
  Type.IntType,
  15
);
const c2 = newBuilderAndCRef2[1];
const newBuilder2 = newBuilderAndCRef2[0];

// Adding an if-else instruction checking if the two constants are equal
const newBuilderAndRef1 = newBuilder2.addIfElse(
  rootNodeRef,
  c1,
  c2,
  false,
  ConditionOperatorType.NumberEOperator
);
const thenRef = newBuilderAndRef1[1];
const elseRef = newBuilderAndRef1[2];
const newbuilder3 = newBuilderAndRef1[0];

// Add a send notification inside the then of the previously created if-else
const thenBuilder = newBuilder3.addSendNotification(
  thenRef,
  Email("pippo@email.com"),
  "Not sent"
);

// Add a send notification inside the else of the previously created if-else
const elseBuilder = thenBuilder.addSendNotification(
  elseRef,
  Email("pluto@email.com"),
  "Sent"
);

// When executing a script created with the *elseBuilder* TaskBuilder, it will be sent a notification to pluto@email.com with the message: "Sent".
```

### ScriptsService

The **ScriptsService** is the _service_ that manage all the *Task*s and *Automation*s.

There are methods to retrieve one or more Tasks/Automations, methods that accept a **ScriptBuilder** to create or modify a Task/Automation, methods that remove a Task/Automation, a method to start a Task and a method to change the state of an automation between enabled or disabled.

At the start of the server, the _ScriptsService_ will start all the automations created that are enabled, starting to listen for **DeviceEvents** (for the DeviceEvent triggered Automations) or waiting (for the period triggered Automations).

When removing or editing an automation, the old one will be stopped if there are no errors while doing it.

# Other doc

- [Description](./README.md)
- [Analysis](./01-Analysis.md)
- [Design](./02-Design.md)
- [Architecture](./03-Architecture.md)
- [DevOps](./04-DevOps.md)

## Distribuited doc

- [Distribuited (next)](./06-Distribuited.md)