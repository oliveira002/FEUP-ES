### Diagram
<figure>
  <p align="center"><img src="https://github.com/LEIC-ES-2021-22/2LEIC06T4/blob/main/images/UseCase.png" alt="Use case for the Course Overview"></p>
  <figcaption><p align="center">Fig 1: Use case for the Course Overview </p></figcaption>
</figure>

### Use case model 

|||
| --- | --- |
| *Name* | Choose Course |
| *Actor* |  Authenticated Student | 
| *Description* | The student has the possibility to choose a course out of the ones he is enrolled.|
| *Preconditions* | - The student has valid Sigarra credentials. <br> - The student is currently enrolled in a degree, and in that specific course.|
| *Postconditions* | - The student is shown the different options he has regarding the group. |
| *Normal flow* | 1. The student accesses the Course Overview App.<br> 2. The student logs in using his Sigarra credentials. <br> 3. The student chooses one the courses he is enrolled. |
| *Alternative flows and exceptions* | 1. [Login Failure] If, in step 2 of the normal flow the student's credentials are not valid, he is not allowed to continue further and is shown an error message. <br>|

|||
| --- | --- |
| *Name* | Display Course Information |
| *Actor* |  Authenticated Student | 
| *Description* | Overview of a simplified but complete version of sigarra courses web pages by using sigarra API. |
| *Preconditions* | - The student has valid Sigarra credentials. <br> - The student is currently enrolled in a degree. |
| *Postconditions* | - The student is shown a simplified version of a specific course description. |
| *Normal flow* | 1. The student accesses the Course Overview App.<br> 2. The student logs in using his Sigarra credentials. <br> 3. The student chooses one of the courses available.<br> 4. He is then shown the simplified version of that course description.<br>|
| *Alternative flows and exceptions* | 

|||
| --- | --- |
| *Name* | Leave Group |
| *Actor* | Authenticated Student | 
| *Description* | The student is able to leave his group. |
| *Preconditions* | - The student must have successfully choosen a course. | <br> - The student must be in a group. |
| *Postconditions* | - The student confirms he wants to leave the group he is taking part in. <br> - The student is removed from the group. <br> - The information of the group is updated.|
| *Normal flow* | 1. The student accesses the Course Overview App.<br> 2. The student chooses the "Choose Course" option <br> 3. The student selects "Leave Group".<br> 4. The page displays the group he is taking part in.<br> 5. The student confirms he wants to leave the group.<br> 6. The student is removed from the group. |
| *Alternative flows and exceptions* | |



|||
| --- | --- |
| *Name* | Join Group |
| *Actor* | Authenticated Student | 
| *Description* | On the course page, the student can join one of the existing groups. |
| *Preconditions* | - The student must have successfully choosen a course. <br> - The student must not be in a group. <br> - The group must not be full. |
| *Postconditions* | - The student selects one of the existing group. <br> - The student is added to the group. <br> - The information of the group is updated. |
| *Normal flow* | 1. The student accesses the Course Overview App.<br> 2. The student chooses the "Choose Course" option.<br> 3. The student selects "Join Group".<br> 4. The page displays all existing groups.<br> 5. The student selects the group he wants to join.<br> 6. The student is added to the group. |
| *Alternative flows and exceptions* | |



|||
| --- | --- |
| *Name* | Create Group |
| *Actor* | Authenticated Student | 
| *Description* | The student can create a group. |
| *Preconditions* | - The student must have successfully choosen a course. <br> - The student must not be in a group. |
| *Postconditions* | - The student creates a group. <br> - The student is added to the group. <br> - The information of the group is updated. |
| *Normal flow* | 1. The student accesses the Course Overview App.<br> 2. The student chooses the "Choose Course" option.<br> 3. The student creates his own group, according to his settings. <br> 4. The student is added to the group. |
| *Alternative flows and exceptions* | |



|||
| --- | --- |
| *Name* | Request Group Schedule |
| *Actor* | Authenticated Student | 
| *Description* | The student has the ability to request for a schedule where every group member is available, so that they can work together at the same time. |
| *Preconditions* | - The student must have successfully choosen a course.  <br> - The student must be in a group.
| *Postconditions* | - The student is displayed a timetable, where every member is free. |
| *Normal flow* | 1. The student accesses the Course Overview App.<br> 2. The student chooses the "Choose Course" option. <br> 3. The student selects "Display Group Schedule". <br> 4. The student is displayed a schedule that fits every group member.|
| *Alternative flows and exceptions* | 1. [Group Members Error] If, in step 4 of the normal flow the student is alone in a group, then an error message is shown. <br>|


|||
| --- | --- |
| *Name* | Manage Request |
| *Actor* | Group Owner | 
| *Description* | The owner of the group has to ability to either accept or reject the request of the other student.|
| *Preconditions* | - The student must be in the group, and the owner of it.
| *Postconditions* | - The other student is added to the group. <br> - The information of the group is updated. |
| *Normal flow* | 1. The owner accesses the Course Overview App.<br> 2. The owner chooses the "Choose Course" option. <br> 3. The owner selects the manage group tab. <br> 4. The owner decides to either accept or reject the request.|
| *Alternative flows and exceptions* | |


|||
| --- | --- |
| *Name* | Authentication |
| *Actor* | Student | 
| *Description* | The student authenticates in the app using his Sigarra credentials.|
| *Preconditions* | - The student has valid Sigarra credentials.|
| *Postconditions* | - The student enters in the app. |
| *Normal flow* | 1. The student accesses the Course Overview App.<br> 2. The student logs in using his Sigarra credentials. <br> 3. The student enters in the app.|
| *Alternative flows and exceptions* ||


### Domain Model
<figure>
  <p align="center"><img src="https://github.com/LEIC-ES-2021-22/2LEIC06T4/blob/main/images/DomainModel.png" alt="Domain Model"></p>
  <figcaption><p align="center">Fig 1: Domain Model for Course Overview </p></figcaption>
</figure>

* Student -> Represents the user of the app, a student from UP.
* Degree -> Represents the degree the student is enrolled. (At most 1)
* Course -> Represents the course the student is enrolled.
* Group -> Represents a group of students for a specific course, all from the same degree.
