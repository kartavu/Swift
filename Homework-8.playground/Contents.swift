// Создаю класс User
class User {
    var name: String?
    var age: Int
    var status: String?
    
    init(name: String?, age: Int, status: String?) {
        self.name = name
        self.age = age
        self.status = status
    }
}

// Создаю три переменные, каждую из которых я приравниваю моему созданнному классу
let firstUser = User(name: nil, age: 25, status: "Married")
let secondUser = User(name: "Margaret", age: 54, status: "Married")
let thirdUser =  User(name: "Kevin", age: 13, status: "Idle")

// Мои созданные переменные я помещаю в массив
var users: [User?] = [firstUser, secondUser, thirdUser]

// Созданный массив я фильтрую по возрасту, старше 18 лет
let filteredUsers = users.filter { user in
    user?.age ?? 0 > 18
}

print(filteredUsers)

// Выше найдя пользователей старше 18, я создаю map чтобы найти имена этих пользователей, он ннайдет двух пользователей с именами Mike и nil, но nil он заменит на ""
let userName = filteredUsers.map { 
    $0?.name ?? "" 
}
print()
print(userName)

// Приеняю compactMap к найдем выше name Mike и "", но выведет он только Mike
let secondfilterdUsers = userName.compactMap { name in
    name.isEmpty ? nil : name
}

print()
print(secondfilterdUsers)
 
