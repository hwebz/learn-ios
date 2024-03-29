module.exports = async function(req, res) {
  const postBody = req.body.postBody;
  console.log('Create post object with text: ' + postBody);

  // Waterline creation syntax
  const userId = req.session.userId;
  const record = await Post.create({ text: postBody, user: userId }).fetch();

  // res.send(record);
  res.redirect('/post')
};