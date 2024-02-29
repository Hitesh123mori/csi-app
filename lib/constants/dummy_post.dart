import '../models/post_model/post.dart';

List<Post> posts = [
  Post(
    createBy: 'user123',
    isThereImage: true,
    likeCount: 10,
    attachmentName: "Contest Poster",
    createTime: DateTime.now().millisecondsSinceEpoch.toString(),
    description: '''Hello everyone!!
CSI is back with another round of the contest series ‘CodeQuest’!!

CodeQuest Round #4
Date: 23-01-2024 (Tuesday)
Time: 9:05 PM to 11:20 PM
Platform: Codeforces🧑🏻‍💻

Whether you're embarking on your coding odyssey or a seasoned pro, this is tailored for all first-year students, from beginners to advanced enthusiasts. 🚀💻🌐

The contest is open for all students.
It will contain 8 problems.
The difficulty of questions will range from very basic to advance level.

Steps to participate:
Create an account if you don't have one on Codeforces:  
https://codeforces.com/register

Join the official CSI Nirma University Group (Join as a participant): https://codeforces.com/group/ernXrWdM7Z/join

-- Register for the contest:
https://codeforces.com/group/ernXrWdM7Z/contests

See you on the leaderboard!!
Happy coding 🤩
~Team CSI

    ''',
  ),


  Post(
    createBy: 'user456',
    likeCount: 15,
    createTime: DateTime.now().millisecondsSinceEpoch.toString(),
    description: '''Hola Nirmaites!✨

Ready for an electrifying journey with the tech pros at Nirma University? 🥳

Join our CSI team—a hub of brilliant minds ready to navigate your best years here! 👩‍💻🎊

Why miss out? Here's the scoop! 😍

CSI Membership Fees:
🔹 1 year: Rs. 350/-
🔹 2 years: Rs. 600/-
🔹 3 years: Rs. 800/-

Exclusive early bird offer for freshers! 🙆‍♀
Secure a 3-year CSI membership for just '₹350'.
Act fast, valid until  13th January 2024

Fill out the membership form pronto: https://forms.gle/x6U6g46W6meJv296A

Here's what you get:
🔸 Chance to interact with fabulous and experienced seniors and alumni network 
🔸 Free entry to all Cubix events 🎉
🔸 Your CSI I-card 📇
🔸 Potential executive and board membership 🤝
🔸 Member-exclusive contests 🏆

Joining our team will lead to academic, professional and organisational development along with boosting technical skills.

For any queries feel free to contact:
Kavish Shah:      7621086446
Shah Stavan:      9328547477
Ayushi Shah:      7016411258

Join the CSI family—let's make tech magic together! 🎊🤩
~Team CSI

    ''',
  ),

  Post(
      createBy: "user123",
      pdfLink:
      'https://drive.usercontent.google.com/u/0/uc?id=1UDvG0vMZUncEBU820ubJxr8mOmfvCNjU&export=download',

      likeCount: 12,
      createTime: DateTime.now().millisecondsSinceEpoch.toString(),
      attachmentName: "Sample.pdf",
      description:
      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et nisl et mi ultrices ultrices. Proin ac ex eu turpis malesuada rhoncus. Quisque vel justo eu urna consequat euismod. Integer euismod neque vitae lacus luctus, in fermentum turpis ultrices. Vivamus convallis justo sit amet nunc fringilla, vel rhoncus dolor ultrices.

Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Ut hendrerit, nulla eu fermentum iaculis, enim orci fringilla risus, non venenatis risus neque sit amet turpis. Fusce nec dolor nec elit laoreet tristique. Sed vel urna vel elit scelerisque venenatis vel non libero.

Donec dapibus, dolor nec accumsan iaculis, elit leo tempor sapien, vel fringilla elit justo eu dolor. Nunc aliquet, nulla at volutpat facilisis, justo lectus aliquam quam, ut dictum turpis nisi at purus. In hac habitasse platea dictumst. Vestibulum nec mi eu arcu malesuada congue. Vivamus auctor justo sit amet augue tristique, eget accumsan mauris fermentum.

Quisque id nunc ut libero varius pharetra. Nam in leo vitae tortor interdum bibendum. Integer bibendum sem vel lectus tempor, vel efficitur justo cursus. Sed eget augue ut odio bibendum scelerisque. Nullam fringilla tellus et varius feugiat. Duis non nibh at nunc cursus lacinia.

      
      ''',
),

  Post(
      createBy: "user234",
      likeCount: 12,
      createTime: DateTime.now().millisecondsSinceEpoch.toString(),
      poll: Poll(
          question: "Tommorow's meeting at...",
          endTime: DateTime.monday.toString(),
          options: [
            Options(title: "Meeting at 9:00 PM", votes: 12),
            Options(title: "Meeting at 10:00 PM", votes: 2),
          ]
      )
  ),
];
