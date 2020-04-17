require "swagger_helper"

RSpec.describe "api/users", type: :request do
  schema_properties = {
    email: { type: :string },
    name: { type: :string },
    github_username: { type: :string },
    registered_at: { type: :datetime },
  }
  path "/users" do
    post "Create a User" do
      tags "Users"
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
                  type: :object,
                  properties: schema_properties,
                  required: ["email", "name"],
                  example: {
                    email: "clovis@example.net",
                    name: "John Justice Wheeler",
                    github_username: "mygithub",
                    registered_at: "2017-09-22T12:13:05.000Z",
                  },
                }
      response "201", "user created" do
        let(:user) { { email: "clark@myemail.com", name: "Clark Johnson" } }
        run_test!
      end
      response "422", "invalid request" do
        let(:user) { { email: "clark@myemail", name: "Clark Johnson" } }
        run_test!
      end
    end
  end

  path "/users/{id}" do
    get "Retrieve a single user" do
      tags "User"
      produces "application/json", "application/xml"
      parameter name: :id, in: :path, type: :string
      response "200", "user found" do
        schema type: :object,
               properties: { email: { type: :string },
                             name: { type: :string },
                             registered_at: { type: :datetime } },
               required: ["id", "email", "name", "registered_at"]
        let(:id) { User.create(email: "clark@myemail.com", name: "Clark Johnson").id }
        run_test!
      end

      response "404", "user not found" do
        let(:id) { "invalid" }
        run_test!
      end
    end
  end
end
