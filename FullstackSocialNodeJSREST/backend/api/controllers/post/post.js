module.exports = async function(req, res) {
  sails.log.warn("Show the post creation form now");

  // Truncate all data in the Post table
  // await Post.destroy({});

  const userId = req.session.userId;
  const allPosts = await Post.find({user: userId})
    .populate('user')
    .sort('createdAt DESC');
  sails.log.warn(allPosts);

  res.view('pages/post/home', {
    allPosts
  });
}