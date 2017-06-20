//
//  global.swift
//  NPLModule
//
//  Created by Wu Wenqi on 10/6/15.
//  Copyright © 2015 SIA App Challenge. All rights reserved.
//

import Foundation

var mxFuckedUp:Bool = false

var user = User()

let N_INPUT_MAIN = 9
let N_OUTPUT_MAIN = 9

let N_INPUT_CONSUMPTION = 10
let N_OUTPUT_CONSUMPTION = 8




// -------------------------------------------------------------

// CHATBOT
// Greetings
// Statement
// Farewell

var greetingWords = ["hi", "hello", "wassup", "yo", "hey", "greetings"]
var greetingReplies = ["Hi there.", "Greetings to you too.", "What's up!", "Hey there."]

var farewellWords = ["bye", "goodbye", "see you"]
var farewellReplies = ["Hey I am still here!", "Don't miss me."]

var statements = ["I'm afraid I don't understand.", "Sorry this is beyond me.", "Give me some time to train up.", "Imitating humans is so hard."]

// -------------------------------------------------------------

var affirmWords = ["okay", "yes", "sure", "alright", "do"]

var denyWords = ["no", "stop", "nevermind", "nope", "never"]

// -------------------------------------------------------------

// FOR PERSONAL ENQUIRES
var userWords = ["name", "seat number", "flight", "wifi key", "wifi voucher", "wireless voucher", "wifi", "wireless", "internet"]

// -------------------------------------------------------------

// FOR MAIN
var mainConnectivityContent = "connect connection email internet network offline online whatsapp wifi wireless"
var mainConnectivityWords = mainConnectivityContent.componentsSeparatedByString(" ")

var mainConsumptionContent = "mutton coke delicious thirsty starving hungry menu drinks drink acorn squash alfalfa sprouts almond anchovy anise appetizer appetite apple apricot artichoke asparagus aspic avocado bacon bagel bake baked bamboo shoots banana barbecue barley basil batter beancurd beans beef beet bell pepper berry biscuit bitter blackberry peas bland orange blueberry boil bowl boysenberry bran bread breadfruit breakfast brisket broccoli broil brownie brown rice brunch sprouts buckwheat buns burrito butter butter bean cake candy cantaloupe capers caramel carbohydrate carrot cashew cassava casserole cater cauliflower caviar cayenne pepper celery cereal chard cheddar cheese cheesecake chef cherry chew chicken chick peas chili chips chives chocolate chopsticks chow chutney cilantro cinnamon citron citrus clam cloves cobbler coconut cod coffee coleslaw collard greens comestibles cook cookie corn cornflakes cornmeal cottage cheese crab crackers cranberry cream cheese crepe crisp crunch crust cucumber cuisine cupboard cupcake curds currants curry custard daikon bread dairy dandelion greens danish pastry dates dessert dine dinner dish dough doughnut dragonfruit dressing drink dry durian eat edible egg eggplant elderberry endive entree feast fed feed fennel fig fillet fire fish flan flax flour food foodstuffs fork fries fried fritter frosting fruit fry garlic gelatin ginger gingerale gingerbread glasses gouda cheese grain granola grape grapefruit gravy greenbean greens tea grub guacamole guava herbs halibut ham hamburger hash hazelnut herbs honey honeydew horseradish hotdog sauce hummus hunger hungry ice lettuce iced tea icing jackfruit jalapeno jam jelly jellybean jicama jimmies jug julienne juice food kale kebab ketchup kitchen kiwi kohlrabi kumquat lamb lard lasagna legumes lemon lemonade lentils lettuce licorice lima beans lime liver loaf lobster lollipop loquat lox lunch lunchmeat lychee macaroni macaroon maize mandarin orange mango maple syrup margarine marionberry marmalade marshmallow potatoes mayonnaise meal meat meatball meatloaf melon menu meringue milk milkshake millet mincemeat minerals mint mints mochi molasses mole sauce mozzarella muffin mug munch mushroom mussels mustard mustard greens mutton napkin nectar nectarine noodles nut nutmeg nutrient nutrition nutritious oats oatmeal oil okra oleo olive omelet onion orange oregano oven oyster pancake papaya parsley parsnip pasta pastry pate patty pattypan squash peach peanut peanut butter pea pear pecan peapod pepper pepperoni persimmon pickle pie pilaf pineapple pita bread pizza plate platter plum pomegranate pomelo pop popsicle popcorn popovers pork potato roast pretzel rib protein prune pudding pumpernickel pumpkin quiche quinoa radish raisin raspberry ravioli recipe refreshments rhubarb ribs rice roll romaine rosemary rye saffron sage salad salami salmon salsa salt sandwich sauce sauerkraut sausage savory scallops scrambled seaweed seeds sesame seed shallots sherbet shish kebab shrimp snack soda bread soup sour soy soybeans soysause spaghetti spareribs spices spicy spinach peas spoon spork sprinkles sprouts squash squid steak stew stir-fry straw strawberry strudel sub sandwich submarine sandwich sugar sundae sunflower supper sushi sweet syrup taco tamale tangerine tapioca taro tarragon tart tea teriyaki thyme toast toaster toffee tofu tomatillo tomato torte tortilla tuber tuna turkey turmeric turnip fruit utensils vanilla veal vegetable venison vinegar wafer waffle walnut wasabi water chestnut watercress watermelon wheat whey whipped cream wok yam yeast yogurt yolk zucchini"
var mainConsumptionWords = mainConsumptionContent.componentsSeparatedByString(" ")


var mainEmergencyContent = "attack bandage blood bruise dead die doctor dying emergency faint headache help hit medical assistance nurse pain swell swelling unwell urgent"
var mainEmergencyWords = mainEmergencyContent.componentsSeparatedByString(" ")


var mainFlightContent = "crew cabin airport arrival arriving arrive depart destination source country departure departing flight fly flying land landing"
var mainFlightWords = mainFlightContent.componentsSeparatedByString(" ")


var mainLodgingContent = "beside cheapest check guesthouse hotel hostel near nearby reserve reservation reception room stay suite vacant"
var mainLodgingWords = mainLodgingContent.componentsSeparatedByString(" ")


var mainLogisticContent = "bag blanket bed cable coat cold cover ear hot jacket piece earpiece headphone headphones luggage recline seat seatbelt seat space belt sheet wire"
var mainLogisticWords = mainLogisticContent.componentsSeparatedByString(" ")


var mainShopContent = "buy catalog cigarette cigarettes gift gifts purchase shop shopping souvenir souvenirs whiskey wine"
var mainShopWords = mainShopContent.componentsSeparatedByString(" ")


var mainTransportContent = "rent bicycle bike train bus cab car cheapest coupe truck drive fastest ferry limo limousine lorry maglev minibus minivan monorail motorcar motorcycle taxi taxicab transport transportation van vehicle"
var mainTransportWords = mainTransportContent.componentsSeparatedByString(" ")


var mainWeatherContent = "air pressure celsius fahrenheit forecast forecasted humidity kelvin rain raining snow temperature weather"
var mainWeatherWords = mainWeatherContent.componentsSeparatedByString(" ")


// FOR MODULE USAGE
// FOR CONSUMPTION
/*
[0]: show
[1]: get
[2]: food specific
[3]: drink specific
[4]: food generic
[5]: drink generic
[6]: hunger
[7]: thirst
[8]: positiveEmotion
[9]: negativeEmotion
*/

var consumptionShowWords = ["show", "display", "present", "provide", "see", "know", "tell", "look"]
var consumptionGetWords = ["have", "get", "give", "serve"]
var consumptionFoodSpecificWords = ["beef", "steak", "salmon", "chicken", "prawns", "sandwich", "fish", "curry", "caramel", "mutton", "bread", "avocado", "cheese", "lamb", "carrot", "pork"]
var consumptionDrinkSpecificWords = ["coffee", "tea", "coke", "gingerale", "sprite", "juice"]
var consumptionFoodGenericWords = ["food", "foods", "snacks", "menu", "breakfast", "brunch", "dinner", "lunch", "hungry", "starving", "hunger"]
var consumptionDrinkGenericWords = ["drink", "drinks", "thirsty", "thirst"]
var consumptionHungerWords = ["hungry", "starving"]
var consumptionThirstWords = ["thirsty"]
var consumptionPositiveWords = ["delicious", "wonderful", "great", "good", "nice"]
var consumptionNegativeWords = ["bland", "disgusting", "unappetizing", "bad"]

// -------------------------------------------------------------



extension CollectionType where Index == Int {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}


func tag(text: String, scheme: String) -> [TaggedToken] {
    let options: NSLinguisticTaggerOptions = [.OmitWhitespace, .OmitPunctuation, .OmitOther]
    let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemesForLanguage("en"),
        options: Int(options.rawValue))
    tagger.string = text
    
    var tokens: [TaggedToken] = []
    
    // Using NSLinguisticTagger
    tagger.enumerateTagsInRange(NSMakeRange(0, (text as NSString).length), scheme:scheme, options: options) { tag, tokenRange, _, _ in
        let token = (text as NSString).substringWithRange(tokenRange)
        tokens.append((token, tag))
    }
    return tokens
}

func partOfSpeech(text: String) -> [TaggedToken] {
    return tag(text, scheme: NSLinguisticTagSchemeLexicalClass)
}

func lemmatize(text: String) -> [TaggedToken] {
    return tag(text, scheme: NSLinguisticTagSchemeLemma)
}

func language(text: String) -> [TaggedToken] {
    return tag(text, scheme: NSLinguisticTagSchemeLanguage)
}
