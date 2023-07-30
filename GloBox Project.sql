# Join activity and users
SELECT * FROM activity
left join users
on users.id = activity.uid

;
# Range date of the experiment
SELECT MIN(dt) as min, MAX(dt) FROM activity
;
# Number of observations
select count(*) from users;
;
# Number of users for each group
SELECT count(*), groups.group from users
full join groups
on groups.uid = users.id
group by groups.group;

;
# Overall conversion rate
(select count(distinct uid)from activity);
(select count(distinct id)from users);

# Number of convertions for both groups;
SELECT count(distinct activity.uid), groups.group from activity
left join groups
on groups.uid = activity.uid
group by groups.group ;
;

# Amount spent by group
select sum(activity.spent), groups.group
from activity
left join
groups
on groups.uid = activity.uid
group by groups.group;

# Average amount spent per user by group

SELECT groups.group, SUM(spent)/COUNT(DISTINCT groups.uid)
FROM groups
LEFT JOIN activity
ON groups.uid = activity.uid
GROUP BY groups.group;



#CSV to extract
SELECT id, country, gender, groups.device, groups.group, SUM(spent) AS sum_spent
FROM users
LEFT JOIN groups ON users.id = groups.uid
LEFT JOIN activity ON groups.uid = activity.uid
GROUP BY id, country, gender, groups.device, groups.group
ORDER BY id;