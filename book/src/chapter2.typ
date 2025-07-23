// Chapter 2: Advanced Development Practices
// This demonstrates how to create additional chapters for your book
#import "lib.typ": *

= Advanced Development Practices

This chapter explores sophisticated development methodologies and tools that enhance productivity and code quality.

== Code Architecture Patterns

Understanding architectural patterns is crucial for building maintainable and scalable applications.

#callout(type: "info", title: "Architecture Benefits")[
Good architecture provides:
- Clear separation of concerns
- Improved testability  
- Better code reusability
- Easier maintenance and debugging
]

=== Model-View-Controller (MVC)

MVC separates an application into three interconnected components:

```python
# models.py - Data layer
class User:
    def __init__(self, username, email):
        self.username = username
        self.email = email
    
    def save(self):
        # Save user to database
        pass

# views.py - Presentation layer  
def user_profile_view(request, user_id):
    user = User.get_by_id(user_id)
    return render_template('profile.html', user=user)

# controllers.py - Business logic
class UserController:
    def create_user(self, username, email):
        if self.validate_email(email):
            user = User(username, email)
            user.save()
            return user
        raise ValueError("Invalid email")
```

=== Repository Pattern

The Repository pattern encapsulates data access logic:

```python
from abc import ABC, abstractmethod

class UserRepository(ABC):
    @abstractmethod
    def find_by_id(self, user_id: int) -> User:
        pass
    
    @abstractmethod
    def save(self, user: User) -> None:
        pass

class DatabaseUserRepository(UserRepository):
    def find_by_id(self, user_id: int) -> User:
        # Database implementation
        return self.db.query(User).filter_by(id=user_id).first()
    
    def save(self, user: User) -> None:
        self.db.add(user)
        self.db.commit()
```

== Development Workflows

Establishing efficient workflows improves team productivity and code quality.

=== Git Workflow Strategies

#callout(type: "note", title: "Git Flow vs GitHub Flow")[
*Git Flow:* Feature branches → Develop → Release → Master

*GitHub Flow:* Feature branches → Master (with pull requests)

Choose based on your release cycle and team size.
]

=== Code Review Best Practices

1. *Keep changes small* - Easier to review and understand
2. *Write descriptive commit messages* - Explain the "why", not just "what"  
3. *Test before submitting* - Ensure code works and tests pass
4. *Be constructive* - Focus on code, not the person
5. *Review promptly* - Don't let PRs sit too long

```bash
# Example of a good commit message
git commit -m "Add user authentication middleware

- Validates JWT tokens on protected routes
- Returns 401 for invalid/expired tokens  
- Adds user context to request object

Fixes #123"
```

== Advanced Testing Strategies

Beyond basic unit tests, consider these testing approaches:

=== Integration Testing

```python
import pytest
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_user_registration_flow():
    # Test complete user registration process
    response = client.post("/api/register", json={
        "username": "testuser",
        "email": "test@example.com",
        "password": "securepass123"
    })
    
    assert response.status_code == 201
    user_data = response.json()
    
    # Verify user can login
    login_response = client.post("/api/login", json={
        "email": "test@example.com", 
        "password": "securepass123"
    })
    
    assert login_response.status_code == 200
    assert "access_token" in login_response.json()
```

=== Property-Based Testing

```python
from hypothesis import given, strategies as st
import string

@given(st.text(alphabet=string.ascii_letters, min_size=1))
def test_username_validation(username):
    # Test that valid usernames are accepted
    result = validate_username(username)
    assert result.is_valid == True

@given(st.text(alphabet=string.punctuation))  
def test_invalid_username_rejected(invalid_username):
    # Test that invalid usernames are rejected
    result = validate_username(invalid_username)
    assert result.is_valid == False
```

== Performance Optimization

Performance considerations should be built into the development process.

#callout(type: "warning", title: "Premature Optimization")[
Remember: "Premature optimization is the root of all evil" - Donald Knuth

Always measure first, then optimize the actual bottlenecks.
]

=== Profiling Tools

```python
import cProfile
import pstats
from functools import wraps

def profile(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        pr = cProfile.Profile()
        pr.enable()
        result = func(*args, **kwargs)
        pr.disable()
        
        stats = pstats.Stats(pr)
        stats.sort_stats('cumulative')
        stats.print_stats(10)  # Top 10 functions
        
        return result
    return wrapper

@profile
def slow_function():
    # Function to be profiled
    pass
```

=== Caching Strategies

```python
from functools import lru_cache
import redis
import json

# Memory caching
@lru_cache(maxsize=128)
def expensive_calculation(n):
    return sum(i * i for i in range(n))

# Redis caching
redis_client = redis.Redis(host='localhost', port=6379, db=0)

def cache_result(expiry=3600):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            cache_key = f"{func.__name__}:{hash(str(args) + str(kwargs))}"
            
            # Try to get from cache
            cached = redis_client.get(cache_key)
            if cached:
                return json.loads(cached)
            
            # Execute function and cache result
            result = func(*args, **kwargs)
            redis_client.setex(cache_key, expiry, json.dumps(result))
            return result
        return wrapper
    return decorator
```

== Documentation as Code

Treat documentation as an integral part of your codebase.

=== API Documentation

```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(
    title="User Management API",
    description="A comprehensive user management system",
    version="1.0.0"
)

class UserCreate(BaseModel):
    username: str
    email: str
    password: str
    
    class Config:
        schema_extra = {
            "example": {
                "username": "johndoe",
                "email": "john@example.com", 
                "password": "secretpass123"
            }
        }

@app.post("/users/", response_model=User)
async def create_user(user: UserCreate):
    """
    Create a new user account.
    
    - **username**: Unique username (3-50 characters)
    - **email**: Valid email address
    - **password**: Strong password (min 8 characters)
    
    Returns the created user object with generated ID.
    """
    return create_new_user(user)
```

#callout(type: "success", title: "Documentation Benefits")[
Well-documented APIs provide:
- Interactive documentation (Swagger/OpenAPI)
- Clear examples for developers
- Reduced support requests
- Better developer experience
]

This chapter has covered advanced development practices that will help you build more robust and maintainable applications. In the next chapter, we'll explore deployment and DevOps practices.
