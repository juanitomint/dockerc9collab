# c9 collaborative Docker container
this project aim to provide a collaborative instance runing in a docker container ready to deploy as a single container or in a composer file
The image is based on official node:7 on debian and compiled on build



## Getting Started

These instructions will get you a fully functional container with an c9 editor ready to use in a project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

## Disclaimer
this container is intended only for internal and small scale use if you need a more robust and well supported web IDE infrastruture please refer to [https://c9.io/](https://c9.io/) - 

### Prerequisites

docker 

docker-compose (if needed)

### build

SETEP 1 build c9
```
./buildc9.sh
```

```
docker build -t juanitomint/c9collab:latest .
```

## Run and c9 editor in current directory

In order to edit a directory all you need to do is to mount a volume pointing to /workspace in the container, and give a port on the host to listen
so for launch an editor in the current working directory and port 9191


```
docker run -it --rm \
-v $(pwd):/workspace \
-p 9191:80 \
juanitomint/c9collab:latest 
```

## Customize user and password

The container use 2 environment variables to set user and password needed to login into C9 ide by default:

C9_USER='developer'

C9_PASSWD='developer'

**If you don't set this environment variables they will be by default:**

user: developer

passwd: developer

So for 

user: johndoe

passwd: johnpassword

```
docker run -it --rm \
-v $(pwd):/workspace \
-e "C9_USER=johndoe" \
-e "C9_PASSWD=johnpassword" \
-p 9191:80 \
juanitomint/c9collab:latest 
```


## Deployment

in orther to deploy this container into composer file set service like this:

```
c9:
    image: juanitomint/c9collab:latest
    # set your dependencies so it wont start until other services started
    depends_on: 
      - web
    #set environment (optional)
    environment:
     - c9_USER : "johndoe"
     - c9_PASSWD : "johpassword"
    
    #map ports to host (optional if you use reverse proxy or other method)
     ports:
       - "9191:80"
    #mount shared volumes for shared project and if needed ssh keys for git to work
    volumes:
      - www:/workspace
      - ssh/:/root/.ssh
```      

## Built With

* [C9 core](https://github.com/c9/core) - The awesome c9 core IDE
* [docker official node](https://hub.docker.com/_/node/) - Node.js is a JavaScript-based platform for server-side and networking applications.


## Contributing

Feel free to fork and make merge request to this repo



## Authors

* **Borda Juan Ignacio** - *Initial work* - [juanitomint](https://github.com/juanitomint)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* C9 crew for their great work and fast response (Harutyun Amirjanyan and Jeff Ruben Daniels)
* nodejs community
* docker community
