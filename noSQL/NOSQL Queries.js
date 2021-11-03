use country_vaccinations


/* 1.	Display a list of total vaccinations per day in Singapore. 
[source table: country_vaccinations] */
db.country_vaccinations.find(
    {country: "Singapore"},
    {date:1, _id:0,total_vaccinations_cleaned:1}
)


/* 2.	Display the sum of daily vaccinations among ASEAN countries.
[source table: country_vaccinations] */
db.country_vaccinations.aggregate(
    {$match:{country: {$in: ["Brunei", "Myanmar" , "Cambodia" , "Indonesia", "Laos", "Malaysia", "Philippines", "Singapore", "Thailand", "Vietnam"]}}},
    {$group: {_id:"$date_cleaned",total_administrated:{$sum: {$round : ["$daily_vaccinations_cleaned",0]} } } },
    {$sort: {"_id":1}},
    {$project: {"total_administrated":1}}
)


/* 3.	Identify the maximum daily vaccinations per million of each country. Sort the list based on daily vaccinations per million in a descending order.
[source table: country_vaccinations] */
db.country_vaccinations.aggregate(
    {$group: {_id:"$country", max_daily_vaccinations_per_million: {$max: "$daily_vaccinations_per_million_cleaned"} } }
    {$sort: {"max_daily_vaccinations_per_million_cleaned":-1}},
    {$project: {"country": 1, "max_daily_vaccinations_per_million":1}}
)

/* 4.	Which is the most administrated vaccine? Display a list of total administration (i.e., sum of total vaccinations) per vaccine.
[source table: country_vaccinations_by_manufacturer] */
db.country_vaccinations_by_manufacturer.aggregate(
    {$group: {_id:"$vaccine", total_administrated: {$sum: "$total_vaccinations_cleaned"} } }
    {$sort: {"total_administrated":-1}},
    {$project: {"vaccine": 1, "total_administrated":1}}
)

/* 5.	Italy has commenced administrating various vaccines to its populations as a vaccine becomes available. Identify the first dates of each vaccine being administrated, then compute the difference in days between the earliest date and the 4th date.
[source table: country_vaccinations_by_manufacturer] */
db.country_vaccinations_by_manufacturer.aggregate(
    {$match:{location: "Italy" } }, 
    {$group:{_id:"$vaccine", date:{$min:"$date_cleaned"} } },
    {$sort: {"date_cleaned" : 1 } }
    {$project: {"vaccine" : 1, "date" : 1} }
)

/* 6.	What is the country with the most types of administrated vaccine?
[source table: country_vaccinations_by_manufacturer] */
db.country_vaccinations_by_manufacturer.aggregate([
    {$group:{_id:{location:"$location",vaccine:"$vaccine"}}},
    {$group:{_id:{location:"$_id.location"},all_vaccine:{$push:"$_id.vaccine"},count:{$sum:1}}},
    {$sort:{count:-1}},
    {$limit:1},
    {$unwind: "$all_vaccine"},
    {$project:{_id:0,"location":"$_id.location","vaccine":"$all_vaccine"}}
    ])
    
/* 7.   What are the countries that have fully vaccinated more than 60% of its people? For each
country, display the vaccines administrated.
[source table: country_vaccinations] */
db.country_vaccinations.aggregate([
    {$group:{_id:{country:"$country"}, vaccines:{$max:"$vaccines"}, vaccination_percentage:{$max:"$people_fully_vaccinated_per_hundred_cleaned"}}},
    {$match:{"vaccination_percentage":{$gt:60}}},
    {$project:{_id:0, "country":"$_id.country", vaccines:1, vaccination_percentage:1}},
    
])

/* 8. Monthly vaccination insight – display the monthly total vaccination amount of each
vaccine per month in the United States.
[source table: country_vaccinations_by_manufacturer]*/
db.country_vaccinations_by_manufacturer.aggregate([
    {$match:{location:"United States"}},
    {$project:{_id:0, month:{$month:"$date_cleaned"}, vaccine:1, total_vaccinations_cleaned:1}},
    {$group:{_id:{month:"$month",vaccine:"$vaccine"}, monthly_total_vaccination:{$max:"$total_vaccinations_cleaned"}}}
    ])
// IDK how to change month to month name

/* 9. Days to 50 percent. Compute the number of days (i.e., using the first available date on
records of a country) that each country takes to go above the 50% threshold of
vaccination administration (i.e., total_vaccinations_per_hundred > 50)
[source table: country_vaccinations] */



/* 10. Compute the global total of vaccinations per vaccine.
[source table: country_vaccinations_by_manufacturer]*/
db.country_vaccinations_by_manufacturer.aggregate([
    {$group:{_id:{location:"$location",vaccine:"$vaccine"}, total_vaccination:{$max:"$total_vaccinations_cleaned"}}},
    {$group:{_id:{vaccine:"$_id.vaccine"}, global_total:{$sum:"$total_vaccination"}}},
    {$project:{_id:0, vaccine:"$_id.vaccine", global_total:"$global_total"}},
    {$sort:{global_total:-1}}
    ])










//Qn9
db.country_vac_clean.aggregate([
    {$project: {country: 1, date: 1, total_vaccinations_per_hundred: 1}},
    {$group: {_id: "$country", minDate: {$min: "$date"}, date50: {$min: {$cond: [{$gt: ["$total_vaccinations_per_hundred", 50]}, "$date", null]}}}},
    {$match: {$and: [{date50: {$ne: null}}, {date50: {$exists: true}}]}},
    {$project: {date_diff: {
        $dateDiff: {
            startDate: "$minDate",
            endDate: "$date50",
            unit: "day"
        }
    }}},
    {$sort: {date_diff: -1}}
])





//Qn 11
//db.gp1.aggregate([
//    {$match:{continent:"Asia"}},
//    {$group:{_id:{continent:"$continent"}, totalPopulation:{$sum:"$population"}}}])
    
db.gp2.aggregate([
    {$match:{continent:"Asia"}},
    {$group:{_id:{country:"$location"}, population:{$avg:"$population_cleaned"}}},
    {$group:{_id:null, totalPopulation:{$sum:"$population"}}}
    ])
    

db.gp2.aggregate([
    {$match:{continent:"Asia"}},
    {$project:{population_cleaned:1, location:1}}
    {$group:{_id:{country:"$location"}, population:{$first:"$population_cleaned"}}}
    {$group:{_id:null, totalPopulation:{$sum:"$population"}}}
    ])
    
    
//Qn12
    
db.gp2.aggregate([
    {$match: {location: {$in: ["Brunei", "Cambodia", "Indonesia", "Laos", "Malaysia", "Myanmar", "Philippines", "Singapore", "Thailand", "Vietnam"]}}},
    {$group: {_id:{location:"$location"}, population:{$max:"$population_cleaned"}}},
    {$group: {_id:null, totalPopulation:{$sum:"$population"}}}
    ])

//Qn13
db.country_vac_clean.aggregate([
    {$group: {_id:null, Unique_data_sources: {$addToSet: "$source_name"}}}])

//Qn14
db.country_vac_clean.aggregate([
    {$match: { $and: [ {country: "Singapore"}, {date: {$gte:ISODate("2021-03-01"),$lt:ISODate("2021-04-01")}}]}},
    {$project: {_id:0,date:1, daily_vaccinations:1}},
    {$sort: {"date":1}}
    
//Qn15
db.country_vac_clean.aggregate([
    {$match: { $and: [ {country: "Singapore"}, {daily_vaccinations: {$gt: 0}}]}},
    {$project: {date:1}},
    {$limit:1}])
    
//Qn16    01-11 or 01-12
db.gp1.aggregate([
    {$match: {location: "Singapore"}},
    {$unwind: "$data"},
    {$match: {"data.date_cleaned": {$gte: ISODate("2021-01-12")}}}
    {$group: {_id:null, total_new_cases:{$sum:"$data.new_cases"}}}
    ])

db.gp2.aggregate([
    {$match: {location:"Singapore"}},
    {$match: {"date_cleaned":  {$gte: ISODate("2021-01-12")}}}
    {$group: {_id:null, total_new_cleaned:{$sum:"$new_cases_cleaned"}}}
    ])
//Qn17
db.gp2.aggregate([
    {$match: {location: "Singapore"}},
    {$match: {"date_cleaned": {$lt: ISODate("2021-01-12")}}}
    {$group: {_id:null, total_new_cases:{$sum:"$new_cases_cleaned"}}}
    ])

//Qn18
db.gp2.aggregate([
    {$match:{location:"Germany"}},
    {$match: {vaccinations_by_manufacturer_data: {$exists: true, $ne:[]}}}
    {$unwind: "$vaccinations_by_manufacturer_data"},
    {$project:{ date:"$date", percentageOfNewCases:{$multiply:[ {$divide: ["$new_cases_cleaned", "$population_cleaned"]}, 100]},
    vaccine: "$vaccinations_by_manufacturer_data.vaccine", totalVaccinations: "$vaccinations_by_manufacturer_data.total_vaccinations_cleaned"}}
    ])

