# Deps yml

> This is a collection of docker compose for generic application dependencies like databases, cache and messaging

### How to use

You have to build the image and run the container at first

```
docker-compose -f [service-name].yml up --build
```

after that, you can just up the container

```
docker-compose -f [service-name].yml up
```