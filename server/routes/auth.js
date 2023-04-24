const express = require("express");
const User = require("../models/user");
const bcryptjs = require('bcryptjs');
authRouter = express();
authRouter.post('/api/signup', async function(req, res){
const {name, email,password} = req.body;
const existingUser = await User.findOne({ email });
try{if(existingUser){
	return res.status(400). json({msg: 'User already exists'});

}
const hashedPassword = await bcryptjs.hash(password,8);
let user = new User({name,
	 email,
	  password : hashedPassword
});



user = await user.save();
res.json(user);}
catch(err){res.status(500).json({msg: err.message})}

})
module.exports = authRouter;