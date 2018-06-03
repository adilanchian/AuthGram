# AuthGram

### Introduction

Application that displays a list of images that can be viewed by all, but only logged in users are able to upload images for everyone to see

#### App Flow

* User opens AuthGram and they are able to view all the images that have been uploaded by others to a public album located [here](https://imgur.com/a/Q4bhF2P)
* After login, the user is brought to an upload section where they can upload their image
* After image is uploaded, the user is brought back to the public image section to view their uploaded image
* If user is not authenticated, they can only view images through AuthGram and not upload them.

### Tech Stack

**_Client_**: iOS/Swift<br>
**_Server_**: Node.js<br>
**_Storage_**: Imgur<br>
**_Auth_**: Auth0
