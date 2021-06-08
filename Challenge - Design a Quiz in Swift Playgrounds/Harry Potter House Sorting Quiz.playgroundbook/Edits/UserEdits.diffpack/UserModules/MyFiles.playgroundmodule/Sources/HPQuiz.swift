
/// Creates a quiz that sorts you into your Harry Potter Hogwarts House
public class HPQuiz {
    
    var responses: [String] = []
    
    var outcomes: [String: String] = [
        "Gryffindor" : "Congratulations, you are a Gryffindor! You have demonstrated qualities like courage, bravery and determination. Some of the wizarding world’s best and brightest belonged to this house – Harry Potter and Albus Dumbledore are just a couple that spring to mind! We imagine you’re the type of person who likes to stand up for the little guy, challenges authority, has a tendency to act first and think later, is known as a class clown and takes board games very seriously.",
        "Slytherin" : "Congratulations, you are a Slytherin! Slytherin house has an unfortunate reputation. While it is true that a lot of dark witches and wizards were sorted into Slytherin, not all who belong to this house are bad. In fact, there are a lot of excellent qualities the Sorting Hat looks for in potential Slytherins and Merlin himself even belonged to this misunderstood house! You are most likely ambitious, shrewd and possibly destined for greatness. We can imagine you’re the kind of person who is always one step ahead, has a dark sense of humour, thinks reputation is important, takes pride in their appearance and doesn’t let anyone see their soft side",
        "Ravenclaw" : "Congratulations, you are a Ravenclaw! You have demonstrated excellent wisdom, wit and a skill for learning. Ravenclaws are often known for being quite eccentric and most of the great wizarding inventors and innovators have come from this house. We can imagine that you would get to sit up in Ravenclaw Tower, while surveying the excellent views, if you’re the type of person who analyses everything, is an overachiever, can be described as away with the fairies, is not afraid to be an individual and has a head stuffed full of interesting facts.",
        "Hufflepuff" : "Congratulations, you are a Hufflepuff! Hufflepuff is where you will find the most trustworthy and hardworking students. In fact, out of all the houses Hufflepuff has produced the least number of dark witches and wizards. We can imagine you’re the type of person who has a strong moral compass, always works hard, is the most loyal friend, knows it is the taking part that counts and always has the best snacks."
    ]
    
    var questions: [String] = [
        "Every student is allowed a pet at Hogwarts: an owl, a cat, or a toad. Which do you bring?", // 0
        "Which class is your favorite?", // 1
        "Which class is your least favorite?", // 2
        "It's Saturday, you've finished your homework, and you have some free time. You decide to spend some time away from your common room. Where do you go?", //3
        "Choose a Deathly Hallow.", //4
        "If you could choose a quidditch position, what would it be?", //5
        "What do people say is your best quality?", //6
        "What do people say is your worst quality?", //7
        "What is your favorite magical creature?", //8
        "Finally: We know that the Sorting Hat takes into account your preferences. So which Hogwarts house do you feel you identify with most closely?" //9
    ]
    
    public var answerChoices: [Int: [String : [String]]] = [
        0 : [
            "Owl🦉" : ["Gryffindor"],
            "Cat🐱" : ["Ravenclaw"],
            "Toad🐸" : ["Hufflepuff"],
            "Nothing. I can't be trusted to look after a pet!" : ["Slytherin"]
        ],
        1 : [
            "Defense Against the Dark Arts☠️" : ["Gryffindor"],
            "Herbology🌿" : ["Hufflepuff"],
            "Potions🧪" : ["Slytherin"],
            "Ancient Runes♐️" : ["Ravenclaw"],
            "Transfiguration🐈" : ["Gryffindor"],
            "Charms✨" : ["Ravenclaw"],
            "Astronomy🪐" : ["Slytherin"],
            "Care of Magical Creatures🦅" : ["Hufflepuff"]
        ],
        2: [
            "Defense Against the Dark Arts☠️" : ["Slytherin"],
            "Herbology🌿" : ["Ravenclaw"],
            "Potions🧪" : ["Gryffindor"],
            "Ancient Runes♐️" : ["Hufflepuff"],
            "Transfiguration🐈" : ["Slytherin"],
            "Charms✨" : ["Hufflepuff"],
            "Astronomy🪐" : ["Gryffindor"],
            "Care of Magical Creatures🦅" : ["Ravenclaw"]
        ],
        3: [
            "The Forbidden Forest🌳" : ["Slytherin"],
            "The Kitchens👩🏽‍🍳" : ["Hufflepuff"],
            "The Library📚" : ["Ravenclaw"],
            "The Room of Requirement✨" : ["Gryffindor"]
        ],
        4: [
            "The Elder Wand🪄" : ["Slytherin"],
            "The Cloak of Invisibility🕵🏻‍♂️" : ["Gryffindor", "Ravenclaw"],
            "The Resurrection Stone🪨" : ["Slytherin", "Hufflepuff"]
        ],
        5: [
            "Seeker👀" : ["Gryffindor"],
            "Chaser🏃🏽‍♀️" : ["Ravenclaw"], 
            "Keeper🧹" : ["Hufflepuff"],
            "Beater🏏" : ["Slytherin"]
        ],
        6: [
            "Bravery🤺" : ["Gryffindor"],
            "Intelligence🧐" : ["Ravenclaw"], 
            "Kindness💕" : ["Hufflepuff"],
            "Cunning😏" : ["Slytherin"]
        ],
        7: [
            "Following your heart, and not your head💞" : ["Gryffindor"],
            "Being narrowsighted👓" : ["Ravenclaw"], 
            "Shyness☺️" : ["Hufflepuff"],
            "Pride👏🏻" : ["Slytherin"]
        ],
        8: [
            "Unicorn🦄" : ["Slytherin"],
            "Hippogriff🦅" : ["Gryffindor"],
            "Bowtruckle🌱" : ["Hufflepuff"],
            "Centaur🐎" : ["Hufflepuff"],
            "House Elf🧝🏾" : ["Ravenclaw"],
            "Goblin👹" : ["Slytherin"]
        ],
        9: [
            "Gryffindor🦁" : ["Gryffindor"],
            "Slytherin🐍" : ["Slytherin"],
            "Ravenclaw🦅" : ["Ravenclaw"],
            "Hufflepuff🦡" : ["Hufflepuff"]
        ]
    ]
    
    var scores: [String] = []
    
    var counts: [String: Int] = [:]
    
    func evaluateResponses() {
        for response in responses {
            let index = (responses.firstIndex(of: response) ?? 0)
            if let score = answerChoices[index]?[response] {
                scores += score
            }
        }
        
        let counts = scores.reduce(into: [:]) { counts, word in counts[word, default: 0] += 1 }
        calculateHouse(from: counts)
    }
    
    func calculateHouse(from data: [String: Int]) {
        let greatestValue = data.max { a, b in a.value < b.value }
        if let house = greatestValue?.key {
            show("Congratulations! You are " + house + "!")
            if let outcome = outcomes[house] {
                show(outcome)
            }
        }
    }
    
    public func start() {
        show("It's time for the Hogwarts House Sorting Ceremony!")
        show("I've done this job for centuries\nOn every student's head I've sat\nOf thoughts I take inventories\nFor I'm the famous Sorting Hat.\n\nI've sorted high, I've sorted low,\nI've done the job through thick and thin\nSo put me on and you will know\nWhich house you should be in...")
        show("🧙🏼‍♂️".image())
        pauseUntilTapped(message: "Ready to Begin?")
        
        for index in 0...(questions.count - 1) {
            show(questions[index])
            if let choices = answerChoices[index] {
                let answer = askForChoice(strings: Array(choices.keys))
                responses.append(answer)
            }
        }
        
        pauseUntilTapped(message: "Are you ready to find out house you are sorted into?")
        evaluateResponses()
    }
    
    public init() {
        
    }
}
