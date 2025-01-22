# DomoticASW

## Developers
- [Alessandro Venturini](mailto:alessandro.venturin6@studio.unibo.it)
- [Francesco Carlucci](mailto:francesco.carlucci6@studio.unibo.it)
- [Corrado Stortini](mailto:corrado.stortini2@studio.unibo.it)
- [Marco Raggini](mailto:marco.raggini2@studio.unibo.it)

## Project description
Create a smart home system and its own protocol, allowing devices to be added or removed dynamically (without having to stop the system).

The protocol enables smart home devices to describe the actions they support and the data they generate.
This means device manufacturers can create compatible devices without requiring changes to the system.

Users interact with the system through web client.
The web client doesn’t talk directly to the smart devices but communicates through a server installed in the house.

The server is also accessible online, so users can manage their home remotely.

Automations can be set up, triggered either by users or external events.

The client can receive custom push notifications from the server, such as:
- Alerts when a device goes offline
- Notifications when the temperature hits a set threshold
- Updates when the washing machine finishes its cycle
- Results of a scheduled automation

There are two types of users:
- **Admin**: Can add and remove devices from the system and define which devices other users can interact with. (The admin also uses the system, he's not technical staff.)
- **User**: Can only interact with devices they’ve been given access to by the admin.

The system includes an authentication feature so that only authenticated users can interact with it.
Users can register themselves but won’t be able to use the system until approved by an admin.

### System Components
- Server
- Web Client
- Multiple IoT devices

### Technologies
We plan to use:
- MEVN stack (using TypeScript where possible)
- Other languages or runtimes to implement the devices
- HTTP REST APIs for client-server and server-device communication
- Docker to containerize components (server and devices)
- Docker Compose for easier development and testing
- Kubernetes for deployment

### Fault Tolerance and Resilience
- Since there are several devices in the house, it’s important for the server to track which devices are active and working properly, detecting offline devices if possible.
- Ensure the server can automatically restart in case of a crash.

## Target users

- **Age range**: 8 -> 75
- **Level of confidence with technology**:
  - Know how to use a smartphone
  - Know how to browse the internet
- **Goals and reasons**:
  - Easier and constant home monitoring
  - Remote interaction with their home or devices
  - Automation to speed up or ease recurring activities
  - Reduce their home environmental footprint
- **Interests**:
  - Keeping their home up to date with the latest technologies
  - Electronics
  - IT
  - Being environment friendly

## Personas

### Alex Carter  
<img src="https://images.pexels.com/photos/1073097/pexels-photo-1073097.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" style="float: right; width: 35%"/>

- **Type of target user**: Geek homeowner
- **Age**: 43
- **Occupation**: Software Engineer  
- **Tech Confidence**: High  
- **Goals**:  
  - Experiment with custom automations for smart devices.  
  - Seamlessly integrate new devices from various manufacturers.
- **Interests**:  
  - Programming, optimizing home workflows, staying on the cutting edge of technology.
- **Relationships**:
  - [Mia Fernandez](#mia-fernandez)'s husband
  - [Liam Carter](#liam-carter)'s parent
  - [Emma Carter](#emma-carter)'s parent


### Mia Fernandez
<img src="https://images.pexels.com/photos/4050291/pexels-photo-4050291.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" style="float: right; width: 35%"/>

- **Type of target user**: Eco-Conscious Parent
- **Age**: 40  
- **Occupation**: Environmental Consultant  
- **Tech Confidence**: Moderate  
- **Goals**:  
  - Monitor and reduce energy consumption at home.  
  - Get notifications on energy usage trends or anomalies.
- **Interests**:  
  - Environment-friendly practices, sustainable living, family well-being.  
- **Relationships**:
  - [Alex Carter](#alex-carter)'s wife
  - [Liam Carter](#liam-carter)'s parent
  - [Emma Carter](#emma-carter)'s parent

### Emma Carter
<img src="https://images.pexels.com/photos/8430249/pexels-photo-8430249.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" style="float: right; width: 35%"/>

- **Type of target user**: Young Teen
- **Age**: 10  
- **Occupation**: Elementary School Student  
- **Tech Confidence**: High given her age  
- **Goals**:  
  - Playfully disrupt Liam’s automations (e.g., turning lights off and on).  
- **Interests**:  
  - Playing games, trying out tech, and sibling rivalry.  
  - Playing music in her room.
- **Relationships**:
  - [Liam Carter](#liam-carter)'s sister

### Liam Carter
<img src="https://images.pexels.com/photos/8185874/pexels-photo-8185874.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" style="float: right; width: 35%"/>

- **Type of target user**: Young Teen
- **Age**: 12
- **Occupation**: Student  
- **Tech Confidence**: Moderate  
- **Goals**:  
  - Customize lights or music for their room.
  - Prank his sister by locking her in her room when she makes fool of him.
- **Interests**:  
  - Gaming setups, customizing room ambiance, experimenting with tech.  
- **Relationships**:
  - [Emma Carter](#emma-carter)'s brother

### Evelyn Moore  
<img src="https://images.pexels.com/photos/7330716/pexels-photo-7330716.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" style="float: right; width: 35%"/>

- **Type of target user**: Elderly User
- **Age**: 72  
- **Occupation**: Retired Teacher  
- **Tech Confidence**: Low  
- **Goals**:  
  - Turn on and off lights without having to get to the switch.
  - Receive clear and concise alerts for critical security events.
- **Interests**:  
  - Home security, maintaining independence.  

### Jordan Patel  
<img src="https://images.pexels.com/photos/6249674/pexels-photo-6249674.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" style="float: right; width: 35%"/>

- **Type of target user**: Mobility-limited User
- **Age**: 32  
- **Occupation**: Freelance Illustrator  
- **Tech Confidence**: Moderate  
- **Goals**:  
  - Use voice commands or simplified controls due to mobility limitations.  
  - Automate routines to enhance accessibility (e.g., blinds opening automatically).  
- **Interests**:  
  - Accessibility tech, convenience, creative pursuits, basketball.  

### Claire Bennett  
<img src="https://images.pexels.com/photos/1181534/pexels-photo-1181534.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" style="float: right; width: 35%"/>

- **Type of target user**: Busy Professional
- **Age**: 45  
- **Occupation**: Corporate Executive  
- **Tech Confidence**: Moderate  
- **Goals**:  
  - Take care of the house remotely due to frequent business trips.
  - Automate recurring tasks like setting the thermostat or starting appliances.  
- **Interests**:  
  - Work-life balance, smart time management, luxury tech.

## Requirements

### User stories
|As a|I want|so that|
|-----|----------|-------------|
|Admin|to add, remove or rename smart devices in my smart home|i can extend my domotic system|
|Admin|to be able to set up user-device permissions and as a consequence tasks can be executed only by users that own the user-device permission for every device included in the task|i can prohibit uninteded use of the system|
|Admin|tasks to have a user whitelist and a user blacklist to override user-device permissions|i can prohibit uninteded use of the system|
|Admin|tasks and automations to have an editlist to specify which user can edit that|i can prohibit uninteded use of the system|
|Admin|to review and accept or decline users registration requests|i can manage who has access to the system|
|Admin|to be able to remove users from the system|i can manage who has access to the system|
|Admin|to organize the home devices in groups|it's easier to manage them|
|User |to see the properties exposed by my smart devices|i can gain knowledge about the state of the house|
|User |to make smart devices execute an action|i can alter the state of the house|
|User |to set up tasks to be executed with one click|i can automate the execution of multiple instructions|
|User |to express conditional logic in my tasks|i can achieve complex behaviour|
|User |to set up automations to be executed periodically or when specific triggering events happen|my home can do stuff even without me taking care of it|
|User |to enable and disable automations|i can stop some automations to run for a while|
|User |to receive a notification when a specific device goes offline|i can fix problems in case they happen|
|User |to edit my profile data like my nickname, email and password|i can keep my data up to date|

### Non functional requirements
- The domotic system must be compatible with devices produced by multiple other manifacturers
- The domotic system should be accessible through the internet so that it can be accessed remotely
- The domotic system should be accessible through the local network so that internet access is not required when the user is phisically in their house
- The domotic system should be accessible both from desktop and mobile clients
- Users (and the admin) must be authenticated in order to interact with the system
- The server should restart automatically in case of a crash

## Ubiquitous language
|Word|Definition|Synonyms|
|----|----------|--------|
|User|A person which interacts with the domotic system||
|Nickname|A simple name or string that the user choose to present himself to other users|Username|
|Email|An e-mail address that it used to identify a user inside the system|E-mail|
|Password|A string that grants the access to a user account||
|Admin|A role played by a user of the system which is responsible for its management|Administrator|
|Smart home|A phisical house equipped with a software to manage connected smart devices|Domotic, Domotic system, Home, System|
|Smart device|An electronic device able to interact or sense the environment, generally connected to other devices or networks|IoT device, device|
|Client|A computer (mobile or desktop) used by the users to interact with the system||
|Remote access|Ability to access the domotic system even if not connected to the local network||
|Property|Some data provided by a smart device|Device data|
|Action|An operation that can be executed by a smart device||
|Notification|A message sent by the server to every user that wants to receive it||
|Instruction|An operation that can be executed by the domotic system (for example running a device action, reading some property on a device or sending a notification, wait for some time, set constants for scripting purposes and start other tasks). Instructions can have inputs||
|Constant|A name with an associated value of a specific type. It can be set manually or by reading a device property|variable|
|Type (scripting)|A set of possible values||
|Control flow instructions|Instructions that can alter the control flow of the task/automation (if and if-else) based on a condition||
|Condition|An expression that results in a boolean value||
|Task|A sequence of instructions to be executed||
|Automation|A sequence of instructions triggered by an automation trigger||
|Active/Inactive automation|An automation that is/is not run by the domotic system when it triggers||
|Automation trigger|A device event or a time period specification|trigger|
|Triggering period|How frequently an automation should be run, has a starting point in time|period|
|Device event|An event that can be fired by a device||
|Offline device|A smart device that is not reachable by the domotic system||
|Interacting with a device|A client that reads properties or runs actions on a smart device||
|User-Device permission|Right of a user to interact with some device|User permission|
|Task permissions|A task whitelist, blacklist and editlist||
|Automation permissions|An automation editlist||
|Task whitelist|A list of users that can run the task regardless of their user-device permissions||
|Task blacklist|A list of users that cannot run the task regardless of their user-device permissions||
|Task/Automation editlist|A list of users which can edit the task/automation||
|Registration request|A user must send a registration request that must be accepted by the admin before he can interact with the system||
|Device group|A grouping of smart devices, each device can be part of 0 or N groups|Group|
|Server|A computer installed in the house responsible for managing all aspects of the domotic system||
|Token|A piece of data that contains information about a user and it's role in the system. It is signed in order to prove it's validity||

## Use case
![Use case diagram](../diagrams/generated/use-case.png)

## Mockups (scenarios)

(This frame cannot be rendered on GitHub so click the link to view it on Figma)
<iframe
style="
  border: 1px solid rgba(0, 0, 0, 0.1);
  height: 700px;"
src="https://embed.figma.com/proto/2LrkXTdBFe5BjsJjpdfBuB/DomoticASW?node-id=1329-206&p=f&scaling=scale-down&content-scaling=fixed&page-id=1214%3A419&starting-point-node-id=1329%3A206&embed-host=share"
allowfullscreen>
</iframe>

Additional details that are not shown in the mockups:

- **Manage tasks**:
  1.After adding an instruction relative to a device, through the "plus" button, it will be added a block with a default action or property of that device. Clicking on the instruction will allow the user change the device action or property

- **Make smart device execute an action**:
  1. When an input control is also used to show the current value of a property, it is not trivial to handle cases in which the value may phisically change slowly.
  1. Right after modifying the content of the input it will be "detached" from the actual property and two buttons (Cancel and Confirm) will be shown.
  1. If "cancel" is pressed then no action is fired and the control returns to be "attached" to the property.
  1. Otherwise if "confirm" is pressed the input control immediately returns to be "attached" to the property and the user will see that value slowly change up to the set one.

- **Sign-up**:
  1. When signing up to the system the first user to do so will immediately become the admin.

- **Manage automations**:
  1. In the "trigger" section the user will choose between triggering by event or periodically.

    - if triggering by event is chosen:

      2. A page with all the devices will be shown and one can be selected.
      2. A block will be added in the trigger section with the device name and a default triggering event.
      2. Clicking that block will allow the user change the triggering event.

    - else if triggering periodically is chosen:

      2. A block will be added in the trigger section with default start time and period
      2. The user can now edit those parameters

## Bounded contexts

- Users management context

  This context handles everything related to user accounts.
  - User login, registration, approval, and removal.
  - Session token verification
  - Editing user profiles (nickname, email, password).

- Devices management context

  This context is responsible for managing the lifecycle of smart devices and the interfaces they offer.
  - Adding, removing, and renaming smart devices.
  - Organizing devices into groups.
  - Tracking device status (online/offline).
  - Exposing device properties and events.
  - Managing device actions (executing them and setting input controls).

- Tasks and automations context

  This context focuses on automating the functionality of the smart home.
  - Defining and executing tasks
  - Defining automations triggered by events or periodically.
  - Managing automation states (active/inactive).
  - Providing graphical scripting capabilities (constants, control flow instructions, and conditions).

- Permissions context

  This context handles everything related to permissions and access control.
  - Handling user-device permissions.
  - task whitelist/blacklist.
  - task/automation editlist.

- Notifications context

  This context handles notifications sent to the users.
  - Sending notifications when devices go offline
  - Sending custom notification from tasks
  - Configuring notification preferences for users.

- System access context

  This context deals with remote/local system access.
  - Supporting local network access when users are home.
  - Enabling remote access for managing the system from anywhere.

![Bounded contexts map](../diagrams/generated/context-map.png)

## Domain modeling
In every upcoming diagram:
- fields are to be considered readonly, changes to those fields will always be mediated by methods.
- default visibility is *public* unless otherwise specified.
- about types the "|" character stands for an union type (so "String | Int" means String OR Int)
- about types the "?" character stands for an optional type
- types that extends generic types by concretizing the type parameter are expressed through an arrow with a \<Type> label.

### Users management
![Users management domain model diagram](../diagrams/generated/users-management-domain-model.png)

This bounded context exposes a *UsersService* which offers all the methods to implement the use cases.

*UsersService* service also includes methods for authentication (*login, verifyToken, validateToken*). The idea is that every other service will use this one to validate authentication tokens received by the client.

### Devices management
![Devices management domain model diagram](../diagrams/generated/devices-management-domain-model.png)

This bounded context exposes a *DevicesService* which offers all the methods to implement the use cases.

More complex stuff explanation:
- The *DeviceFactory* is able to create a *Device* just through an URL as it will contact the device on that address which will then describe himself.
- The main service will be responsible for keeping the devices *DeviceStatus* up to date, and allows for subscribers to listen to status change events.
- The main service will be responsible for receiving *DeviceEvent*s (through the *publishEvent* method) from the devices, and allows for subscribers to be notified about *DeviceEvent*s.
- *DeviceGroup*s are responsible for managing the N-N relationships with *Device*s.
- The *DevicesService* is responsible for keeping *DeviceGroup*s up to date in case of device removal.

#### TypeConstraints
Since devices will define their own action and properties they must also define what datatypes they are.

Types are defined in the *Type* enum which is generic on T which reprents the actual datatype that will be used internally.

A *TypeConstraint* is a constraint over a type which can also have additional constraints over the values, for example:
An input which requires an integer from 0 to 100 can be modeled as a subclass of *TypeConstraint* with *Type* "IntType" which overrides the *validate* method implementing that logic (in the diagram we called this *IntRange*).

*DeviceProperty*s which have a setter will use its *TypeConstraint*, otherwise they will have their own *TypeConstraint*.

A setter is a *DeviceAction* whose execution is expected to set a property with the given input. This allows to create richer user interfaces where properies and actions are bound.

*DeviceAction*s have just one *TypeConstraint* which constraints the input they can take. Actions that require no input can be implemented by an input of *Type* "VoidType".
