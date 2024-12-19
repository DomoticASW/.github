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
- **Admin**: Can add and remove devices from the system and define which devices other users can interact with. (Admins also use the system, they’re not technical staff.)
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

- **Age**: 40  
- **Type of target user**: Eco-Conscious Parent
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
- **Tech Confidence**: High for her age  
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
