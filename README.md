# Patient Injections API

This API helps patients with hemophilia manage their treatments, record injections, and track how well they follow their treatment plan.

## 📋 Technologies Used

- **Ruby:** 3.4.3
- **Rails:** 8.0.2
- **Database:** SQLite3
- **API Documentation:** Swagger (rswag)
- **Monitoring:** Prometheus Exporter

## 🚀 How to Run the Application

### Using Docker

The project is set up to run easily with Docker:

```bash
# Build and start the application
docker-compose up --build

# Run in background mode
docker-compose up -d
```

The application will be available at `http://localhost:3000`

## 🔍 How to Use the API

### Swagger Documentation

Complete API documentation is available through Swagger UI:

**URL:** `http://localhost:3000/api-docs`

From there you can explore and test all available endpoints.

### Main Endpoints:

#### Create a Patient
- **POST** `/patients`
- Returns an `id` and `api_key` that will be used to authenticate other operations

#### Record an Injection
- **POST** `/patients/:patient_id/injections`
- Requires authentication with the patient's `api_key`
- Parameters: dose, batch number, medication

#### Get Injections
- **GET** `/patients/:patient_id/injections`
- Requires authentication with the patient's `api_key`

#### Get Adherence Score
- **GET** `/patients/:patient_id/adherence_score`
- Requires authentication with the patient's `api_key`
- Returns a percentage showing how well the patient follows their treatment

## 🧪 Running Tests

```bash
# Inside Docker container
docker-compose exec web bundle exec rspec

# Or directly if you have Ruby installed locally
bundle exec rspec
```

## 📊 Monitoring with Prometheus

The project provides metrics for Prometheus on port 9394. This endpoint is protected by basic authentication using the `my-htpasswd-file`.

**URL:** `http://localhost:9394/metrics`

To access it, you need to provide the credentials set up in the htpasswd file.

Claro, aquí tienes un apartado en inglés que podés agregar a tu README bajo la sección de **🔒 Security** o crear una nueva sección llamada **🧪 Metrics Authentication Notice**, como prefieras:


## 🧪 Metrics Authentication Notice

> ⚠️ For the purposes of this challenge, the Prometheus metrics endpoint is protected with **basic authentication** using the credentials:
>
> * **Username:** `admin`
> * **Password:** `diego`

This was intentionally added to simulate a scenario where access to monitoring endpoints is restricted. The password file (`my-htpasswd-file`) is included **only as part of this test project** and does **not** expose any sensitive or production data.

Please note that committing authentication files to public repositories is **not a recommended practice** in real-world applications. For this challenge, it was included solely for demonstration purposes and to show awareness of access control mechanisms in monitoring.


## ✅ Implemented Features

### Minimum Requirements:
- ✅ Patient creation with secure `id` and `api_key`
- ✅ Injection recording with all required fields
- ✅ Query injections for a specific patient
- ✅ Calculate treatment adherence score
- ✅ Security using `api_key` to protect endpoints
- ✅ Unit and integration tests

### Bonus Features:
- ✅ **API Documentation:** Implemented with Swagger UI using rswag
- ✅ **Prometheus Metrics:** System and application metrics with authentication
- ✅ **CI/CD:** GitHub Actions for automatic test and linter execution
- ✅ **Advanced Validations:** Using dry-validation for complex business rules

## 🛠️ Project Structure

The project follows standard Rails structure with some additions:

- `app`: Main application code
- `spec`: Automated tests
- `swagger`: API documentation
- `Dockerfile` and `docker-compose.yml`: Docker configuration

## 🔒 Security

- Injection and adherence score endpoints are protected by the patient's `api_key`
- Prometheus metrics endpoint is protected by basic authentication
- Input validation is implemented for all parameters

## 🏥 About Hemophilia Treatment

This API helps patients track their factor replacement therapy, which is essential for managing hemophilia and preventing bleeding episodes.