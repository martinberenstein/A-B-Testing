-- 1. Join activity and users
SELECT *
FROM activity
LEFT JOIN users ON users.id = activity.uid;

-- 2. Range date of the experiment
SELECT MIN(dt) AS min_date, MAX(dt) AS max_date
FROM activity;

-- 3. Number of observations
SELECT COUNT(*) AS observation_count
FROM users;

-- 4. Number of users for each group
SELECT COUNT(*) AS user_count, groups.group
FROM users
FULL JOIN groups ON groups.uid = users.id
GROUP BY groups.group;

-- 5. Overall conversion rate
SELECT COUNT(DISTINCT uid) AS total_conversions
FROM activity;

-- 6. Number of conversions for each group
SELECT COUNT(DISTINCT activity.uid) AS conversions_count, groups.group
FROM activity
LEFT JOIN groups ON groups.uid = activity.uid
GROUP BY groups.group;

-- 7. Amount spent by group
SELECT SUM(activity.spent) AS total_spent, groups.group
FROM activity
LEFT JOIN groups ON groups.uid = activity.uid
GROUP BY groups.group;

-- 8. Average amount spent per user by group
SELECT groups.group, SUM(spent) / COUNT(DISTINCT groups.uid) AS avg_spent_per_user
FROM groups
LEFT JOIN activity ON groups.uid = activity.uid
GROUP BY groups.group;

-- 9. CSV to extract
SELECT
    users.id,
    users.country,
    users.gender,
    groups.device,
    groups.group,
    SUM(activity.spent) AS total_spent
FROM users
LEFT JOIN groups ON users.id = groups.uid
LEFT JOIN activity ON groups.uid = activity.uid
GROUP BY users.id, users.country, users.gender, groups.device, groups.group
ORDER BY users.id;
