# Mock Youtube API

## Getting Started

### 1. Clone the Repository
Clone the repository to your local machine using the following command:

```bash
git clone https://github.com/savvychien/mock-youtube-backend.git
cd mock-youtube-backend
```

### 2. Build and Start the Application
Use Docker Compose to build and run the application along with Redis. Run the following command in the project root:

```bash
docker-compose up --build
```

### 3. Access the Application
Once the containers are running, you can access the Rails application in your web browser at:

```
http://localhost:3000
```

### 4. Running Migrations
To run the database migrations, you can execute the following command:

```bash
docker-compose run web rails db:create db:migrate db:seed
```

### 5. Stopping the Application
To stop the running application, press `CTRL + C` in the terminal where you started Docker Compose, or run:

```bash
docker-compose down
```

## Configuration
You may want to configure environment variables in a `.env` file. Create a file named `.env` in the root directory of your project and set your Redis URL:

```plaintext
REDIS_URL=redis://redis:6379/1
```