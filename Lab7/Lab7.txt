db.C14403588_teams.drop()
db.C14403588_avg.drop()

//Question 1: create a collections called your_student_id_teams and insert the documents about teams and football players contained in this file
db.createCollection("C14403588_teams");

db.C14403588_teams.insert({
	team_id: "eng1",
	date_founded: new Date("Oct 04, 1896"),
     league: "Premier League",
	 points: 62,
	 name: "Manchester United",
     players: [ { p_id: "Rooney", goal: 85, caps: 125, age: 28 },
              { p_id: "Scholes", goal: 15, caps: 225, age: 28 },
			  { p_id: "Giggs", goal: 45, caps: 359, age: 38 } ]
	 });

db.C14403588_teams.insert({
	team_id: "eng2",
	date_founded: new Date("Oct 04, 1899"),
     league: "Premier League",
	 points: 52,
	 name: "Arsenal",
     players: [ { p_id: "Mata", goal: 5, caps: 24, age: 27 },
              { p_id: "Bergkamp", goal: 95, caps: 98, age: 48 } ]
	 });

db.C14403588_teams.insert({
	team_id: "eng3",
	date_founded: new Date("Oct 04, 1912"),
     league: "Premier League",
	 points: 65,
	 name: "Chelsea",
     players: [ { p_id: "Costa", goal: 15, caps: 25, age: 28 },
              { p_id: "Ivanov", goal: 5, caps: 84, age: 28 },
			  { p_id: "Drogba", goal: 105, caps: 125, age: 35 } ]
	 });

db.C14403588_teams.insert({
	team_id: "spa1",
	date_founded: new Date("Oct 04, 1912"),
     league: "La Liga",
	 points: 80,
	 name: "Barcelona",
     players: [ { p_id: "Messi", goal: 195, caps: 189, age: 30 },
              { p_id: "Valdes", goal: 0, caps: 158, age: 27 },
			  { p_id: "Iniesta", goal: 72, caps: 25, age: 31},
			  { p_id: "Pique", goal: 9, caps: 201, age: 38 } ]
	 });

db.C14403588_teams.insert({
	team_id: "spa2",
	date_founded: new Date("Nov 04, 1914"),
     league: "La Liga",
	 points: 72,
	 name: "Real Madrid",
     players: [ { p_id: "Ronaldo", goal: 135, caps: 134, age: 28 },
				 { p_id: "Bale", goal: 75, caps: 45, age: 27 },
				 { p_id: "Marcelo", goal: 11, caps: 25, age: 31 },
              { p_id: "Benzema", goal: 125, caps: 95, age: 22 } ]
	 });

db.C14403588_teams.insert({
	team_id: "spa3",
	date_founded: new Date("Oct 04, 1912"),
     league: "La liga",
	 points: 68,
	 name: "Valencia",
     players: [ { p_id: "Martinez", goal: 26, caps: 54, age: 21 },
              { p_id: "Aimar", goal: 45, caps: 105, age: 29 } ]
	 });
	 
db.C14403588_teams.insert({
	team_id: "ita1",
	date_founded: new Date("Oct 04, 1922"),
     league: "Serie A",
	 points: 69,
	 name: "Roma",
     players: [ { p_id: "Totti", goal: 198, caps: 350, age: 35 },
              { p_id: "De Rossi", goal: 5, caps: 210, age: 30 },
			  { p_id: "Gervinho", goal: 43, caps: 57, age: 24 } ]
	 });
	 
db.C14403588_teams.insert({
	team_id: "ita2",
	date_founded: new Date("Oct 04, 1899"),
     league: "Serie A",
	 points: 52,
	 name: "Juventus",
     players: [ { p_id: "Buffon", goal: 0, caps: 225, age: 37 },
              { p_id: "Pirlo", goal: 45, caps: 199, age: 35 },
			  { p_id: "Pogba", goal: 21, caps: 42, age: 20 } ]
	 });

db.C14403588_teams.insert({
	team_id: "ita3",
	date_founded: new Date("Oct 04, 1911"),
     league: "Serie A",
	 points: 62,
	 name: "AC Milan",
     players: [ { p_id: "Inzaghi", goal: 115, caps: 189, age: 35 },
              { p_id: "Abbiati", goal: 0, caps: 84, age: 24 },
			  { p_id: "Van Basten", goal: 123, caps: 104, age: 35 } ]
	 });

db.C14403588_teams.insert({
	team_id: "ita4",
	date_founded: new Date("Oct 04, 1902"),
     league: "Serie A",
	 points: 71,
	 name: "Inter Milan",
     players: [ { p_id: "Handanovic", goal: 0, caps: 51, age: 29 },
              { p_id: "Cambiasso", goal: 35, caps: 176, age: 35 },
			  { p_id: "Palacio", goal: 78, caps: 75, age: 31 } ]
	 });

/*Question 2: Insert two new players
   - add a player to the Man. Utd. team. Player id:  Keane, 44 yers old, 326 caps, 33 goals.
   - add a player to the AC Milan team. Player id:  Kaka, 32 yers old, 112 caps, 53 goals.*/
db.C14403588_teams.update(
	{"name": "Manchester United"},
	{$push: { players: { p_id: "Keane", goal: 33, caps: 326, age: 44 }}}
);

db.C14403588_teams.update(
	{"name": "AC Milan"},
	{$push: { players: { p_id: "Kaka", goal: 53, caps: 112, age: 32 }}}
);

db.C14403588_teams.find({"name":"Manchester United"});
db.C14403588_teams.find({"name":"AC Milan"});

// Question 3: Find the oldest team
db.C14403588_teams.find({}, {"name": 1}).sort({"date_founded" : 1}).limit(1).pretty();

// Question 4: Update the number of goal of all the Real Madrid Players by 3 goals each
var team = db.C14403588_teams.find({"name": "Real Madrid"});

team.forEach(function (setter){
  for(var index in setter.players){
    db.C14403588_teams.update(
    {"name": "Real Madrid",
    "players.goal": setter.players[index].goal},
    {$inc: {"players.$.goal":3}});
}});

db.C14403588_teams.find({"name": "Real Madrid"});

//Question 5: Using a cursor, update the number of caps of all the "Serie A" teams by incrementing them by 10%
var update_caps = db.C14403588_teams.find({league: "Serie A"});
var update_caps_array = update_caps.toArray();

for (var i in update_caps_array) {
  var player = update_caps_array[i].players;

  for (var j in player) {
    caps = Math.round(player[j].caps + (player[j].caps * 10/100));

		var update={};
		update["players."+j+".caps"] = caps;

		db.C14403588_teams.update({"_id" : update_caps_array[i]._id}, {$set : update});
}};

db.C14403588_teams.find({"name": "AC Milan"});

// Question 6: Update the points of Arsenal to be equal to the point of Barcelona
var barca_points = db.C14403588_teams.find({"name": "Barcelona"}, {"points": 1});

while(barca_points.hasNext()){
	db.C14403588_teams.update({"name": "Arsenal"}, {$set: {"points": barca_points.next().points}})
};

db.C14403588_teams.find({name:'Arsenal'});

//Question 7: Find all the players over 30 years old containing the string "es"
db.C14403588_teams.aggregate([
    { $unwind: "$players" },
    { $match: { 'players.age': { $gt: 30}} },
    { $match: {"players.p_id": { $regex : "es" }}}]
);

//Question 8: Using aggregate mongoDB operator, list the total point by league
db.C14403588_teams.aggregate([
	{$group: { _id: {league: "$league"}, total:{ $sum: "$points"}}
}]);

//Question 9: Using aggregation, list all the teams by number of goals in descending order.
db.C14403588_teams.aggregate([
  {$unwind : "$players"},
  { $group: { _id: { $toLower: "$name" }, total: { $sum: "$players.goal" }}},
  { $sort: { total: -1 }}]
);

/*Question 10: ompute the average number of goal per match per player and store the output in a collection 
named student_id_avg_goals.*/
db.C14403588_teams.aggregate([
  {$unwind : "$players"},
  {$project: { _id: "$players.p_id",avg_goals: {$divide: ["$players.goal", "$players.caps"]}}},
  {$out: "C14403588_avg"}
]);

db.C14403588_avg.find();

/*Question 11: Write a js function old_vs_young(x) , that receives a positive integer x representing the age of a player
and returns 1 if the total number of goals scored by the players with age >= x years is greater than the 
total number of goals scored by the players with age < x, otherwise it returns 0.
The function also prints the number of goals for each group of players*/
function old_vs_young(x){
  var older_val = 0
  var younger_val = 0
  
  var older = db.C14403588_teams.aggregate([
  {$unwind: "$players"},
  {$match: {"players.age" : { $gte: x}}},
  {$group: {_id: null, total: { $sum: "$players.goal"}}},
 ]);
 
  var younger = db.C14403588_teams.aggregate([
  {$unwind: "$players"},
  {$match: {"players.age" : { $lt: x}}},
  {$group: {_id: null, total:{ $sum: "$players.goal"}}},
 ]);
 
 while(older.hasNext()){
  older_val = older.next().total
 }
 
 while(younger.hasNext()){
  younger_val = younger.next().total
 }
 
 print("Older goals: " + older_val)
 print("Younger goals: " + younger_val)
 
 if(older_val > younger_val){
   return 1
 }
return 0
}

old_vs_young(30)