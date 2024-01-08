class Meal {
  final String mealTime, name, imagePath, kiloCaloriesBurnt, timeTaken;
  final String preparation;
  final List ingredients;

  Meal({
    required this.mealTime,
    required this.name,
    required this.imagePath,
    required this.kiloCaloriesBurnt,
    required this.timeTaken,
    required this.preparation,
    required this.ingredients,
  });
}

final meals = [
  Meal(
      mealTime: "BREAKFAST",
      name: "Genfo",
      kiloCaloriesBurnt: "881",
      timeTaken: "10",
      imagePath: "assets/genfo.jpg",
      ingredients: [
        "1 cup of granola",
        "1 banana",
        "1/2 cup of raisins",
        "1 tbsp of honey",
      ],
      preparation:
          '''Genfo, a native breakfast in Ethiopia, is a thick porridge made with barley or wheat flour. This meal is usually paired with niter kibbeh (Ethiopian spiced clarified butter) and berbere sauce, giving it that delicious taste and look.

Genfo is cooked with toasted barley flour, wheat flour, or even maize meal. The flour is poured into boiling water and stirred with a wooden spoon until it thickens and becomes smooth.

The porridge is usually molded like a Bundt cake. The porridge mold has a round orifice that serves to hold/contain the Ethiopian chili oil sauce made with chilies, clarified butter, and flax or sunflower seeds.

Genfo is an excellent source of protein and can fill up the energy you need for half a day. Being a shared dish that’s mainly eaten with the hands, porridge chunks are taken outside and dipped into the center’s butter and spice mixture.'''),
  Meal(
      mealTime: "DINNER",
      name: "Shiro Wot",
      kiloCaloriesBurnt: "353",
      timeTaken: "15",
      imagePath: "assets/shiro-wot.jpg",
      ingredients: [
        "To make shiro powder, you'll need - chickpea flour, berbere powder, garlic powder, ground cardamom, and cumin powder",
        "For the rest, you'll need olive oil, onions, tomato paste, minced garlic and salt. Easy, peasy",
      ],
      preparation:
          '''Shiro wot is another variety of Ethiopian stews, and you can almost always find it on a mixed plate at an Ethiopian restaurant, just like doro wot.

Shiro is a simple powder mixture of chickpea flour, dried onion, and granulated garlic. However, an elaborate mix usually constitutes ginger, berbere spices, tomatoes, and chili peppers.

While the chickpeas give the stew a nutty flavor, shiro wot generally has a smooth, creamy consistency that’s perfect for eating injera, rice rolls, or other flatbreads. However, it’s best served with the traditional injera to get every last taste of this soupy delight.

A vibrant bowl of this delicious stew results from the various spices blending harmoniously. You may use it as a starter or garnish for other meals. Last but not least, although cost-effective—since meat isn’t introduced—this stew is highly nutritious.'''),
  Meal(
      mealTime: "SNACK",
      name: "Sambusa",
      kiloCaloriesBurnt: "202",
      timeTaken: "16",
      imagePath: "assets/sambusa.jpg",
      ingredients: [
        "1 cup brown lentils",
        "1 medium yellow onion, diced",
        "⅓ cup oil",
        "2 jalapeños, deseeded and diced",
        "2 cloves garlic, diced",
        "1 tsp grated ginger",
        "1 tsp ground coriander",
        "Salt and pepper",
        "½ (4.7-oz) package egg roll/spring roll wraps (or 8 sheets of phyllo pastry, halved)",
        "Vegetable oil for frying (about 4 cups)",
      ],
      preparation:
          '''Place the lentils in a pot, add enough water to cover them by 2 inches, and bring to a boil over medium heat. Cook, stirring occasionally, until the lentils are al dente, about 5 minutes. You don’t want them fully cooked or mushy. Remove from the heat, drain, and set aside.

Place the onions and oil in a skillet. Cook over medium heat until the onions are translucent and beginning to brown, about 5 minutes. Stir in the jalapeños, garlic, and ginger. Cook to soften slightly, about 5 minutes. Stir in the lentils and coriander, making sure the coriander does not clump. Turn down the heat to low, add salt and pepper to taste, and stir. Cover the pot and let cook, stirring occasionally, until the lentils are fully cooked, 8–10 minutes. Remove from the heat and set aside.

Working with one egg roll wrapper at time, fold each sheet into a cone and add 2 tablespoons of lentils. Fold in the top edges of the wrapper to close it, brush a little water along each edge, and seal. Repeat the process with the remaining wrappers and filling.

Place 4 cups of oil in a deep, heavy-bottomed pot. The oil should be at least 4 inches deep, but it shouldn’t come more than halfway up the sides of the pot, so adjust the amount as required. Place the pot over high heat and bring the oil to boiling point (365°F). Deep-fry a few sambusas at a time, making sure they are submerged in the oil and gently turning them so they cook evenly on each side. Give the oil a few minutes to return to temperature between batches. Once they are golden brown, about 5 minutes, use a slotted spoon to remove them from the pot and place on paper towel or parchment paper to drain the oil.

Serve while warm with a side of sauce—my personal favorites are awaze or kochkocha—or by itself.

Note: For the meat version of this dish, called ye siga sambusa (beef sambusas), substitute the lentils with 1 pound of ground beef. Place the beef in a pot and add enough water to cover it by 2 inches. Bring to a boil over medium heat and cook, stirring occasionally, until rare/medium-rare but not fully cooked, about 5 minutes. Remove from the heat, drain, and follow the method above from paragraph 2 to the end.'''),
];
