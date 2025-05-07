# School Data Hub

Software tool to handle school information flows between teachers / administrative office in an effective, collaborative way.

### Origins

This software originated during the COVID-pandemic in the primary school "Hermannschule" in Stolberg (Germany). In order to keep track on attendance and quarantine statuses a simple app was developed to keep records in a collaborative way with a simple backend built with flask.

Recognizing the time saving potential that brought handling this information digitally, the app was expanded with information sets that are handled every day in schools and cause long ways (walking across the school), cost time and organization resources, or leave long paper trails.

### So what does it do?

The app takes exported information from the software provided by the NRW Education ministry (https://www.svws.nrw.de/) and uses it to build extended models of the schools' pupils in the backend  without uploading any personal data to the server^. The models in the backend are then used to add additional information.

### Data protection efforts

A singular approach that this app takes is the **transport of personal information through encrypted qr-codes**. It works like this:

1. When the client is installed, it needs school keys. Without them, it is useless.
2. As a security procedure, the school keys are kept securely as an unencrypted qr-code in the school's office. **Whoever wants to use the school data, has to come at least once.**
3. A user comes to the office and scans the school keys containing the URL of the server and encryption keys. These are stored in the device's secure storage.
4. Now the user can log in with their credentials. However, after the login process, there will still not be any pupils' data to call /display.
5. Now, the user has to scan the pupils' credentials, tipically from the desktop version of the app installed in the administrative computer that has the education ministry software installed. With it, a .txt file with the pupils' data can be exported. The desktop version of this app can import this file and create / update data in the backend. The personal data is stored in the secure storage. With it - and with the encryption keys - the app can generate encrypted qr-codes that can be read with other clients to import the pupil identities. API calls are only possible with this pupil data (and jwt tokens for authentication).

#### But why so complicated?

The aim is to ensure that the pupils' personal data isn't sent back and forth through the internet. In fact, this way the personal data is only transported through devices over encrypted qr-codes. As we are storing quite sensitive information, it is crucial that this information can't be related to a concrete pupil without proper authorization.

**Have you got a better idea? Pull requests welcome! :-)**

#### What else is encrypted?

For now, all stored images.

### Features already implemented

#### Attendance

- keep track of presence, minutes late, excused / unexcused, gone back home (e.g. for being sick), parents reached/not reached

#### Schoolday Events

- keep track of schoolday events and document them with a picture of a document (or whatever you want to photograph). Schoolday events could be an admoniton, an accident report, a parents meeting (anything you need to document) or any other incident associated with a pupil.
  
#### School Lists

- create private (user) or public check lists to keep track of whatever you need to keep track of (paid money for a day trip, signed form from the parents, ...), including a field for comments.
  
#### Authorizations

- authorizations are like lists, but an image can be attached, too. We use it for things that we need to keep a record from, like signed authorizations from the parents/guardians - for instance the authorization to take an avatar picture for this app.
  
#### Accounts

- In our school there is a school own currency. It is used as a reward system to motivate pupils. With this currency, they can buy stuff in the school's own shop (like school t-shirts or buttons, but also pencils, erasers, or little games like frisbees and such).

#### Special information

- In case parents/guardians provide special information that everyone needs to know (like allergies, emergency medication, likelyhood of having an epilleptic stroke..), it can be called in a special list.

#### Individual learning support (WIP)

Pupils have the right to get learning support according to their individual needs. Being an inclusive school, this also includes special needs. Our local school authority provides mandatory categories that we have to use to describe individual needs and formulate/follow specific educational goals. These have to be documented / kept record of, too. It is also essential, that this information is available to any colleague working with the pupil, and that all colleagues involved cooperate and share information.

- This app can work with any category tree - this means, you could use your own.

- Based on this tree, the app can document category statuses - as estimated by the responsible colleague for the pupil - and keep track of progress collaboratively.

- It also can document development goals, which are ideally formulated together with the pupil. 

#### Pupil profile

- All information about a pupil is bundled in a pupil profile view. Here you can call additional information like the parents' language proficiency in German (since over 90% of the families in our school do not speak German at home, this is relevant to us), siblings information, or information about afterschool care.

#### Filters

- Filters are incredibly useful when dealing with lists. There are general filters (like class, schoolyear) and specific filters for the different views implemented, as well as different ordering of the list elements according to different criteria depending on the view.

#### Matrix: User accounts and room management with Matrix Corporal (WIP)

- If you configure a synapse server to work with Matrix Corporal https://github.com/devture/matrix-corporal , you can now easily administer accounts and room membership, including per user power levels in the rooms.

#### Calendar (WIP)

- Calender view to see  / add / delete schooldays. Additionally, the attendance list of the selected date is shown. (To do: add more than one day at a time with https://pub.dev/packages/calendar_date_picker2 )

#### User management (WIP)

UI to add, update, and delete users.

### Roadmap

The export of reports in a printable format (pdf) is  on top of the list.

There are also a couple of models in the backend that are not implemented in the client yet, like a digital library management.


## Setup

You will need a school key - if you don't have one yet, you can generate one with the client.

Format for the keys is:

```
{
"server": "{Name of your server}",
"key": "{your encryption key}",
"iv": "{your initialization vector}",
"server_url": "{$your_instance_url/api}"
}
```

### Url for a local development instance

If you are setting up a local development environment, the `server_url` will depend on which platform you are using for the client:

- if you are using windows, it will be: `http://127.0.0.1:5000/api`
- if you are using an android simulator, you need to use `http://10.0.2.2:5000/api`
  
### TO-DO:

#### Code quality / architecture

- migrate filter architecture to `PupilsFilter` (work in progress)
- subsitute hard coded enum filters for class and school grade with a dynamic solution, so that the app can be used for other schools. **Priority: high**
  
#### Functionality

- error handling in API calls. **Priority: high**
- review state management across pages. **Priority: high**
- handle 'no internet connection' case **Priority: high**
- review / implement navigation **Priority: medium**
- internationalization
- generally, improve code quality. The naming of models, functions and such should definitely be revisited by an actual programming person.**Priority: low (it works like this)**

#### Design

- review widgets design (rows/columns), and for that matter, the overall design structure (for instance implementing a theme). **Priority: medium**
  
#### Features


- UI for semester management
- pdf export feature: individual development plan report. **Priority: high**
- implement competence feature, competence report for a school semester and pdf export. **Priority: high**
- workbook feature **Priority: medium**
- book feature (library lending system) **Priority: medium**
- generate qr stickers as shortcuts for documenting features **Priority: low**

### Credits

Thanks to the open source community!

Original code written by @dabblingwithcode .

Thanks to @escamoteur (developer of get_it and watch_it) for kindly answering questions and helping out in a couple of sessions with state management, the PupilProxy model and its filters.
