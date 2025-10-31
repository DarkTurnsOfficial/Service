FROM node:20-alpine

RUN apk add --no-cache git

WORKDIR /app

ARG REPO_URL=https://github.com/DarkTurnsOfficial/dogeub.git
ARG BRANCH=main

RUN git clone --depth 1 --branch ${BRANCH} ${REPO_URL} ./dogeub || \
    git clone --depth 1 ${REPO_URL} ./dogeub

WORKDIR /app/dogeub

COPY .env* ./

RUN sed -i 's/app.listen({ port })/app.listen({ port, host: "0.0.0.0" })/' server.js

RUN npm install

RUN npm run build

EXPOSE 2345

CMD ["node", "server.js"]
