# QuizApi-vapor
Quiz api made with Vapor framework and Fuent ORM 

## Install

- run the migrations: `swift run App migrate`
- Run the application `swift run App serve`

## API Documentation

### Endpoints

#### Category Endpoints

- **GET /categories**: Retrieves paginated categories with the count of associated questions.
- **GET /categories/:catId/count**: Gets the count of questions for a specific category.
- **POST /categories**: Creates a new category.
- **DELETE /categories/:catId**: Deletes a specific category.

#### Question Endpoints

- **GET /questions**: Retrieves paginated questions with their answers and categories.
- **GET /questions/category/:categoryId**: Retrieves paginated questions for a specific category.
- **POST /questions**: Creates a new question with answers.
- **DELETE /questions/:questionId**: Deletes a specific question and its answers.

#### Health Check Endpoints

- **GET /health/ping**: Returns "pong" for health check purposes.
