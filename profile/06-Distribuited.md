# Distribuited

## Authors

[Corrado Stortini](mailto:corrado.stortini2@studio.unibo.it), [Francesco Carlucci](mailto:francesco.carlucci6@studio.unibo.it), [Marco Raggini](mailto:marco.raggini2@studio.unibo.it)

## Usage Examples

The GUI is a website made in Vue + Html + Css.

We have prepared a [full demo](https://github.com/DomoticASW/demo) to allow you to test it.
In this demo there are already users, devices and tasks/automations ready to use.
To run it, this is the command:

```sh
docker compose up -d
```
Once the docker containers are all up, you can go to http://localhost to view the website.

1. **Login** with an existing user/ **register** with a new user (you have to wait the approval of an admin in this last case to make the login)
2. In the **Device** page (the first to appear) you can view the devices and interact with them if you have permissions to do so.
3. You can then go to other pages from the tabs on the top bar of the application: **Tasks**, **Automations**, **Notifications**, **Settings**, and **Admin** only if you are an admin.
    1. The **Admin** tab is a topdown menu where you can go to different administration pages like: **Users**, **Devices**, **Devices Groups**, **User Device Permissions** and **Scripts permissions**
4. In the **Notifications** page you can see all the notifications sent to you, and can possibly delete them (they are not stored in the server, so they are only available to see in that session)
5. In the **Settings** page you can modify the nickname and the password (the email cannot be modified)
6. In the **Tasks** page you can execute an already existing task (if you have the right permissions to do so), create a new task or edit an existing one (if you have the right permissions to do so).
    1. If you want to create a task, click on the add button on bottom of the page.
        1. If you instead want to edit an existing one, you should click on the row of that task (this let you go on read-only mode) and then click to edit in the top bar (edit-mode).
    2. Set a name for the task.
    3. Put all the **instructions** you want to put inside the task.
    4. You can move **instructions** up/down by means of the arrow buttons at their left, or remove them with the cross button at their right.
    4. Save to actually create/edit the task.
7. In the **Automations** page you can enable/disable automations (if you have the right permissions to do so), create a new automation or edit an existing one (if you have the right permissions to do so).
    1. The process of creating/editing an automation is almost the same of the tasks, but with one difference.
    2. You **must** create a **trigger** for the automation with the button under the name of the automation, either period trigger or device event trigger.
        1. The **period trigger** indicates when and how often the automation should fire.
        2. The **device event trigger** indicates which device event will fire the automation.
    3. You can then modify the parameters of the triggers like you would do with an instruction.
8. In the **User** administration page you can remove some users from the server or accept/remove the requests of new users.
9. In the **Device** administration page you can modify the name of already registered devices, remove them from the server, or add new devices.
    1. To add new devices, click on the bottom button of the page.
    2. Click the "plus" button on the right of the devices you want to add.
10. In the **Device Groups** administration page you can modify the name of the device groups, create new/modify groups.
    1. To add/remove devices to a group, click on the row of that group.
    2. You now see all the devices on the server, to add a device click on the right button ("plus" button) of the devices under the "Device not in group" title.
    3. To remove a device, click on the "cross" button at their right.
11. In the **User Device Permissions** Administration page you can edit the permissions of the users on the devices.
    1. To modify the permission of a user, click on the row of that user.
    2. Click on the "cross" button to the right of a device to remove it.
    3. Click on the "plus" button to the right of a device to add it.
12. In the **Scripts Permissions** page you can edit the scripts permissions of the users.
    1. Click on a task or an automation to edit the permissions that users have on that task/automation.
    2. For a task, there are three lists, Whitelist, Blacklist and Editlist, for an automation there is only the Editlist one.
    3. To add a user to a list, click on the "plus" button to their right.
    4. To remove a user from a list, click on the "cross" button to their right.

In almost all of the pages there is an "info" button that explains exactly what you can do in that page (like what instructions do and why).

## Tests

The development of the server has been done following the TDD metodology.

Unfortunatly, for the Scripts part it was really hard to test everything because there are a lot of different outcomes when it comes to programming (there are Ifs, If-Elses, that can be also nested and with checking of constant declarations etc.), so it was preferred to test them from the GUI interface.

The test of the GUI has been done entirely from the GUI itself.
The devices were tested only by the GUI and with means of PostMan. (There were not really requirements about them, so it was preferrable to just test their comunication with the server)

### Passing tests

All of the tests are passing correctly and are checked automatically every time a Pull Request is done.

### Amount of tests

There are 34 test suites, with 439 total tests.

### Tests coverage

| File                                             | % Stmts   | % Branch   | % Funcs   | % Lines   | Uncovered Line #s                                                      |
| ------------------------------------------------ | --------- | ---------- | --------- | --------- | ---------------------------------------------------------------------- |
| All files                                        | 91.18     | 92.98      | 88.81     | 91.18     |
| adapters                                         | 97.56     | 93.33      | 100       | 97.56     |
| BaseRepositoryMongoAdapter.ts                    | 97.56     | 93.33      | 100       | 97.56     | 39-40,55                                                               |
| adapters/devices-management                      | 98.32     | 86.36      | 100       | 98.32     |
| DeviceGroupRepositoryMongoAdapter.ts             | 100       | 100        | 100       | 100       |
| DeviceRepositoryMongoAdapter.ts                  | 97.99     | 84.21      | 100       | 97.99     | 194,196,200,206,212                                                    |
| adapters/notifications-management                | 100       | 100        | 100       | 100       |
| DeviceOfflineNotificationSubscription.ts         | 100       | 100        | 100       | 100       |
| adapters/permissions-management                  | 83.52     | 87.09      | 83.72     | 83.52     |
| EditListRepositoryMongoAdapter.ts                | 67.12     | 85.71      | 75        | 67.12     | 49-50,64-65,86-87,93-106,109-122,125-138                               |
| TaskListsRepositoryMongoAdapter.ts               | 94.49     | 86.36      | 92.3      | 94.49     | 59-60,74-75,96-97                                                      |
| UserDevicePermissionRepositoryMongoAdapter.ts    | 95.87     | 89.47      | 85.71     | 95.87     | 50-51,67-68                                                            |
| adapters/scripts-management                      | 98.1      | 97.56      | 100       | 98.1      |
| ScriptRepositoryMongoAdapter.ts                  | 98.1      | 97.56      | 100       | 98.1      | 325-329,449-453                                                        |
| adapters/users-management                        | 100       | 100        | 100       | 100       |
| RegistrationRequestRepositoryAdapter.ts          | 100       | 100        | 100       | 100       |
| UserRepositoryAdapter.ts                         | 100       | 100        | 100       | 100       |
| domain/devices-management                        | 97.72     | 94.05      | 97.45     | 97.72     |
| Device.ts                                        | 99.57     | 94.59      | 100       | 99.57     | 143                                                                    |
| DeviceActionsServiceImpl.ts                      | 100       | 100        | 100       | 100       |
| DeviceEventsServiceImpl.ts                       | 100       | 100        | 100       | 100       |
| DeviceGroup.ts                                   | 100       | 100        | 100       | 100       |
| DeviceGroupsServiceImpl.ts                       | 99.5      | 96.49      | 90.47     | 99.5      | 100                                                                    |
| DeviceStatusesServiceImpl.ts                     | 98.26     | 95.83      | 100       | 98.26     | 81-82                                                                  |
| DevicesServiceImpl.ts                            | 99.27     | 97.61      | 100       | 99.27     | 56,108                                                                 |
| Types.ts                                         | 89.85     | 80.39      | 96.87     | 89.85     | 16-17,19-20,22-23,28-29,126-127,172-174,176-178,180-182,184,186        |
| domain/notifications-management                  | 94.76     | 96.66      | 77.77     | 94.76     |
| DeviceOfflineNotificationSubscription.ts         | 100       | 100        | 100       | 100       |
| NotificationsServiceImpl.ts                      | 94.19     | 96.55      | 76.47     | 94.19     | 115-117,131-136                                                        |
| domain/permissions-management                    | 75.32     | 96.45      | 72.91     | 75.32     |
| EditList.ts                                      | 100       | 100        | 100       | 100       |
| PermissionsServiceImpl.ts                        | 71.46     | 95.86      | 67.9      | 71.46     | ...9,333-340,383-386,454-461,504-538,566-586,634-668,696-716,719-729   |
| TaskLists.ts                                     | 100       | 100        | 100       | 100       |
| UserDevicePermission.ts                          | 100       | 100        | 100       | 100       |
| domain/scripts-management                        | 90.15     | 89.23      | 88.33     | 90.15     |
| Instruction.ts                                   | 100       | 100        | 100       | 100       |
| InstructionImpl.ts                               | 99.64     | 93.75      | 100       | 99.64     | 159                                                                    |
| Operators.ts                                     | 100       | 100        | 100       | 100       |
| Refs.ts                                          | 100       | 100        | 100       | 100       |
| Script.ts                                        | 100       | 100        | 100       | 100       |
| ScriptBuilder.ts                                 | 91.33     | 70.66      | 100       | 91.33     | ...0-231,237-240,255-256,265,280-281,283-286,351-352,392-393,396-399   |
| ScriptsServiceImpl.ts                            | 75.55     | 88.88      | 57.14     | 75.55     | ...2,396-397,402-414,418-420,423-431,434-459,479-482,514-520,546-549   |
| Trigger.ts                                       | 100       | 100        | 100       | 100       |
| domain/users-management                          | 91.84     | 92.5       | 90        | 91.84     |
| RegistrationRequest.ts                           | 100       | 100        | 100       | 100       |
| Token.ts                                         | 100       | 100        | 100       | 100       |
| User.ts                                          | 100       | 100        | 100       | 100       |
| UsersServiceImpl.ts                              | 89.19     | 90.9       | 85.18     | 89.19     | 122-127,205-215,237-248,267-268                                        |
| ports                                            | 100       | 100        | 100       | 100       |
| Repository.ts                                    | 100       | 100        | 100       | 100       |
| ports/devices-management                         | 100       | 100        | 100       | 100       |
| Errors.ts                                        | 100       | 100        | 100       | 100       |
| Types.ts                                         | 100       | 100        | 100       | 100       |
| ports/permissions-management                     | 53.65     | 100        | 40        | 53.65     |
| Errors.ts                                        | 53.65     | 100        | 40        | 53.65     | 21-23,25-33,35-41                                                      |
| ports/scripts-management                         | 100       | 100        | 100       | 100       |
| Errors.ts                                        | 100       | 100        | 100       | 100       |
| ports/users-management                           | 88.13     | 100        | 85.71     | 88.13     |
| Errors.ts                                        | 88.13     | 100        | 85.71     | 88.13     | 45-51                                                                  |
| utils                                            | 100       | 100        | 100       | 100       |
| MongoDBErrorCodes.ts                             | 100       | 100        | 100       | 100       |
| ------------------------------------------------ | --------- | ---------- | --------- | --------- | ---------------------------------------------------------------------- |

## Deployment Instructions

For the deployment of our application we decided to use Kubernetes.

To run the system, go to the server repository, then here there are some instructions to be executed.

1. To make the changes you do on the server persistents execute the following command:
```sh
kubectl apply -f ./k8s/persistence
```

2. To start the server and the DB execute the following command:
```sh
kubectl apply -f ./k8s/deployment
```

3. To start the devices (these are just to test the server without having real devices):
```sh
kubectl apply -f ./k8s/devices
```

To stop the server and/or the devices use one or both of the following commands:
```sh
kubectl delete -f ./k8s/deployment
kubectl delete -f ./k8s/devices
```

To reset the DB use the following command:
```sh
kubectl delete -f ./k8s/persistence
```

## CAP Theorem

### Partitioning

Our system heavily relies on the server part, which usually would not be a really good choice, but in our scope the server runs **locally** on a computer, without being hosted on internet (and, even if so, a local server needs always to exists, making a remote server a sort of a "proxy" of the real one), removing then all the implications of the net (like being unable to contact the server without internet). 

The only things that can occur to the server in order to make it unavailable are really rare and (nowadays) also not very likely to happen, like:
1. The light goes off. (In this case it is not possible to recover in any way).
2. The computer hosting the server crushes (In this case it is not possible to recover in any way),
3. The computer hosting the server not being powerful enough for the application (It is an SPA so it is a really light application).

This made us focus more on the aspects of **Availability** and **Consistency**, making **network Partitioning** less "important".

### Availability

The **Availability** is really well achieved in our system because every time something fails (like a device not reachable by the server of a device going online) the user interested is notified, either by a notification or a popup.

The server find offline devices sending a request of "check-status" every 5 seconds, if they answer it with status code 202 they are healthy, otherwise either they answer with an error (specifying the cause) or don't answer at all (they are offline).

### Consistency 

Our system is also really well **Consistent** because we use MongoDB API for the DB with one replica, and at the application level, each instruction (add, get, getAll, remove, update) ensures that it does only if in the right circumstances.

1. It is possible to add an element just if it is not a duplicate by checking a key and sometimes even a name.
2. It is possible to get an element just if an element with that key already exists.
3. It is always possible to get all the elements (if not present, it just returns an empty list).
4. It is possible to remove an element just if an element with that key already exists.
5. It is possible to edit an element just if an element with that key already exists and sometimes it is checked also the uuniqueness of its (maybe) new name.

In all these cases, the user is notified that something went wrong with a pop-up.

## Scalability

Unfortunatly, the server (also due to the low partitioning and the same reasons above) is not easy to be scaled, but usually being it a server used locally just for the devices inside an house and the users inside an house (about 4/5 for family or 20/30 for agencies), the **scalability** we think is an aspect of a less importance respect to the **availability** and **consistency** (an user doesn't want to think that a device is doing something when it does not, or viceversa).

## Server Replicas and Fault Tolerance

With kubernetes we tried to make **server replicas**, but there were problems were the devices where comunicating updates to random replicas and not just one of them (the one comunicating also with the GUI), we tried with the "sessionAffinity: ClientIP" configuration but it was not working, so at last we decided to stuck with only one replica of the server. 

We think that something that could have been really good to do for **fault tolerance** is deciding which replica is the "main" one and which are the ones to be used only in case of a failure, maybe in the application level.

## Future works

We think in the future some works that can be done are:

1. Make server replicas works with the logic we described above.
2. Add more types of data that devices can manage, like streams (for videocameras or music players, and so on so forth).
3. Notify also when a device comes back online (We think this is the only thing of availability not being present, but it should be really easy to add).

## What did we learned

Being a really big project, we learned really lot of things, like:

1. Co-working with teammates.
2. Thinking about Distribuited aspects (primary Availability and Consistency).
3. Using Docker and Docker Compose for the development and testing of the application.
4. Deploying an application with Kubernetes.
5. Creating emulations of real world IoT devices.
