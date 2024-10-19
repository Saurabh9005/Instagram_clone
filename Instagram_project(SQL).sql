select * from comments;
select * from follows;
select * from likes;
select * from photo_tags;
select * from photos;
select * from tags;
select * from users;
#1.Create an ER diagram or draw a schema for the given database.

#2.We want to reward the user who has been around the longest, Find the 5 oldest users.
select * from users order by created_at asc limit 5 ;



#3.To understand when to run the ad campaign, figure out the day of the week most users register on? 
select dayofweek(created_at) as daynumber,dayname(created_at) as dayname,count(*) as registrations
from users group by dayname order by registrations desc limit 3;


#4.To target inactive users in an email ad campaign, find the users who have never posted a photo.
select username from users u LEFT join photos p on p.user_id=u.id where p.id is null; 


#5.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
select u.username,count(l.photo_id) as no_of_likes from users u inner join photos p on p.user_id=u.id 
inner join likes l on p.id=l.photo_id group by photo_id order by no_of_likes desc limit 1;


#6.The investors want to know how many times does the average user post.
select(select count(*) from photos) / (select count(*) from users) as average;



#7.A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
select t.tag_name, count(pt.tag_id)as number_of_times_used from photo_tags pt inner join tags t on pt.tag_id=t.id 
group by tag_id order by number_of_times_used desc limit 5;


#8.To find out if there are bots, find users who have liked every single photo on the site.
select username,count(*) as num_likes from users u 
inner join likes l on u.id=l.user_id 
inner join photos p on p.id=l.photo_id
group by l.user_id
 having num_likes in (select count(*) from photos);


 
#9.To know who the celebrities are, find users who have never commented on a photo.
select username,comment_text from users u left join comments c on c.user_id=u.id
group by c.user_id
having comment_text is null;


#10.Now it's time to find both of them together, 
#find the users who have never commented on any photo or have commented on every photo
 



SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

