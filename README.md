# Chat System
* Instabug Backend Challenge for the Backend Developer II position.
## Languages and frameworks 📑
* Ruby on Rails
* MySql
* ElasticSearch
* Redis
* Sidekiq
## Features 🥇
* Easy create, update and show apps, chats and messages using Ruby on Rails framework.
## Cloning the repo and starting the app
* clone the repository and open the project in any IDE
``` bash
git clone https://github.com/MohamedRagaab/Instabug-Backend-Challenge.git
cd Instabug-Backend-Challenge
```
* You can run the following command to start the app
``` bash
docker compose up
```
or 
``` bash
docker-compose up
```
## Usage 🚀
* Here is the list of the RESTful APIs
  - Application:
 
    - Create a new application:
        ``` bash
        POST /api/v1/applications
        ```
    - Read a specific application:
        ``` bash
        GET /api/v1/applications/:token
        ```
    - Update a specific application:
        ``` bash
        PUT /api/v1/applications/:token
        ```

  - Chats:
 
    - Create a new chat:
        ``` bash
        POST /api/v1/applications/:token/chats
        ```
    - List chats under a specific application:
        ``` bash
        GET /api/v1/applications/:token/chats
        ```
        
  - Message:
 
    - Create a new message:
        ``` bash
        POST /api/v1/applications/:token/chats/:number/messages
        ```
    - Read a specific message under a chat:
        ``` bash
        GET /api/v1/applications/:token/chats/:chat_number/messages/:message_number
        ```
    - Update a specific message:
        ``` bash
        PUT /api/v1/applications/:token/chats/:number/messages/:id
        ```
    - List all messages under a specific chat:
          ``` bash
        GET /api/v1/applications/:token/chats/:number/messages
        ```  


















## Example 🖼️
* Register your account
<div align='center'>
<img height="400px" src="https://github.com/MohamedRagaab/MohamedRagaab/assets/38363762/1e8ec78e-3caa-4ab1-b837-c1c1f7ee54f7">
<hr/>
</div>

* Login with your credentials
<div align='center'>
<img height="400px" src="https://github.com/MohamedRagaab/MohamedRagaab/assets/38363762/1f45f519-48f5-4e63-95ec-420fce4520c2">
<hr/>
</div>

* Access the home page!
<div align='center'>
<img height="400px" src="https://github.com/MohamedRagaab/MohamedRagaab/assets/38363762/99e7544d-5b6a-4ab7-a145-636fe1841469">
<hr/>
</div>

## Some Validations
* Login with wrong credentials
<div align='center'>
<img height="400px" src="https://github.com/MohamedRagaab/MohamedRagaab/assets/38363762/b1bd7b41-33d2-4803-8845-2cff4937bd7d">
<hr/>
</div>

* Register with the same email or username
<div align='center'>
<img height="400px" src="https://github.com/MohamedRagaab/MohamedRagaab/assets/38363762/c2f016af-321d-45e7-a4da-55db41d07de9">
<hr/>
</div>
