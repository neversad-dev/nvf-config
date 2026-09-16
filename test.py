def greet(name: str) -> str:
    message=f"Hello, {name}!"
    return message


users = ["Alice", "Bob", "Charlie"]
for user in users:
    print(greet(user))
