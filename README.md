# Docker compose tutorial: profile app

A small profile page (Node.js + Express) that saves up to several user profiles in MongoDB.
The whole stack runs with Docker Compose: the app, MongoDB and mongo-express.



## Project structure

```
.
├── Dockerfile               # How to build the app image
├── mongo.yaml               # Docker Compose file (app, mongodb, mongo-express)
├── .env.example             # Example of the environment variables
├── .dockerignore
└── app/                     # Application code
    ├── server.cjs
    ├── package.json
    ├── package-lock.json
    └── public/              # Static files (index.html, index.css, index.js, images/)
```



## Prerequisites

- [Docker](https://www.docker.com) (Docker Desktop must be running)

[ Node.js is not needed on your computer: dependencies are installed inside the image when it is built. ]



## Setup


### Create the .env file (copy from the example)

```bash
cp .env.example .env
```


### Start mongodb e mongo-express

```bash
docker start mongodb mongo-express
```

Then edit it if you want different values. Add your profile pictures (`.jpg`, `.jpeg`, `.png`, `.gif`, `.webp`) in `app/public/images/`.


## Start the project

```bash
docker compose -f mongo.yaml up -d --build
```

- `--build` rebuilds the app image: use it the first time and after every change to the code.



## Open the project

- App: http://localhost:3000
- mongo-express: http://localhost:8081

[ Mongo Express is the web interface for viewing and editing the data in MongoDB. It is not required for the app to work. ]
[ MongoDB saves the data in a Docker volume (`mongo-data`), so it persists even if the containers are removed. ]



## Credentials

|                                What                                | Username |  Password  |
|--------------------------------------------------------------------|----------|------------|
| MongoDB (root user, set with the environment variables above)      | `admin`  | `password` |
| mongo-express web login (browser pop-up at http://localhost:8081)  | `admin`  |   `pass`   |

These are example values for local use only.



## Useful commands

```bash
# Start the containers (if created yet)
docker compose -f mongo.yaml start

# Stop the containers (they can be started again)
docker compose -f mongo.yaml stop

# Remove the containers (data is kept in volumes)
docker compose -f mongo.yaml down

# Remove the containers and volumes (data is not kept)
docker compose -f mongo.yaml down -v

# Show the status of the containers
docker compose -f mongo.yaml ps

# Follow the logs of a service (app, mongodb, mongo-express)
docker compose -f mongo.yaml logs -f <name_of_service_>
```



## Troubleshooting

- `port is already allocated`: another container or program is using port 3000, 8081 or 27017. Stop it (`docker ps` shows the running containers).
- Changed the code but nothing changes: run `up -d --build` again, and reload the page with `Cmd+Shift+R`.
- MongoDB credentials only apply the first time the volume is created: if you change them later, use `down -v` to start from scratch.



## Thanks to

Thanks to [TechWorld with Nana](https://www.youtube.com/@techworldwithnana) for the Docker tutorial this project is based on.
Check out her channel and her [website](https://www.techworld-with-nana.com/) for more DevOps and cloud content.
The reference video is ["Docker tutorial for Beginners"](https://www.youtube.com/watch?v=3c-iBn73dDE).
