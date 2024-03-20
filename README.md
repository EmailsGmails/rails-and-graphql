# README

# A Rails + GraphQL Application

## Introduction

This is a basic application that demonstrates user creation and posting, built using Ruby on Rails and GraphQL. It can serve as the back-end prototype for a platform that utilzes users making posts. The application includes authentication with token-based authorization.

## Setup and Running the Application

### Prerequisites

- Ruby (version 3.2.0)
- Ruby on Rails (version 7.1.2)

### Installation

1. Clone this repository to your local machine.
2. Navigate to the project directory.
3. Run `bundle install` to install the necessary gems.
4. Setup the database by running `rails db:create` and `rails db:migrate`.
5. Start the Rails server by running `rails s`.

## GraphQL Queries and Mutations

- Access the GraphQL interactive interface at `/graphiql` to execute the following queries and mutations.

### Queries

- **Get All Users**: Retrieve a list of all users.
  ```graphql
    query {
      users {
        id
        name
        email
      }
    }

- **Get User by ID**: Retrieve a user by their ID.
  ```graphql
    query {
      user(id: "1") {
        id
        name
        email
        posts {
          id
          title
          content
        }
      }
    }

- **Get all posts by User ID**: Retrieve all posts created by a specific user.
  ```graphql
    query {
      postsByUser(userId: "1") {
        id
        title
        content
        user {
          id
          name
        }
      }
    }

- **Who am I**: Pass a valid token in the Authorization header to check what user it belongs to, if any.
  ```graphql
    query {
      whoAmI
    }

### Mutations

- **Create User** Create a new user.
  ```graphql
    mutation {
      createUser(
        input: {
          name: "John Doe"
          email: "johndoe@example.com"
          password: "asdf1234"
      })
      {
        user {
          id
          email
          name
        }
        success
        errors {
          fullMessages
        }
      }
    }

- **Authentication** Authenticate with a user and receive the Authorization token
  ```graphql
    mutation {
      authentication (
        input: {
          email: "johndoe@example.com"
          password: "asdf1234"
      }) {
        user {
          id
          email
          name
        }
        success
        token
      }
    }

- **Create Post**: Pass a valid token in the Authorization header and create a new post.
  ```graphql
    mutation {
      createPost(
        input: { title: "My n-th Post", content: "Hello World!" }
      ) {
        post {
          title
          content
        }
        success
        errors {
          details
          fullMessages
        }
      }
    }

## Testing
- Unit tests: Run `bundle exec rspec` to execute the unit tests.

## Deployment
1. Configure your deployment environment (e.g., Heroku, AWS).
2. Push your code to the deployment repository.
3. Configure the necessary environment variables
    1. `BASE_URL` (default: `http://localhost:3000`)
4. Run any database migrations (rails db:migrate) if required.
5. Start the server in production mode.

## License
This project is licensed under the MIT License.

Feel free to utilize this as a base for your own Rails & GraphQL application customize this template as per your project requirements. Good luck with your application!
