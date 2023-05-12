const jwt = require("jsonwebtoken");
const User = require('../models/user');
const admin = async (req, res, next) => {
	try {
		// Extract the token from the `x-auth-token` header.
		const token = req.header("x-auth-token");
		if (!token)
		  return res.status(401).json({ msg: "No auth token, access denied" });
	    
		// Verify the token signature and get the decoded payload.
		const verified = jwt.verify(token, "passwordKey");
		if (!verified)
		  return res
		    .status(401)
		    .json({ msg: "Token verification failed, authorization denied." });
		    const user = await User.findById(verified.id);
		    if(user.type == "user" || user.type == "seller"){
			return res.status(401).json({ msg: "you are not a admin"});
		    }
	    
		// Attach the user ID and token to the request object for further use.
		req.user = verified.id;
		req.token = token;
	    
		// Call the next middleware or route handler function.
		next();
	      } catch (err) {
		// Handle errors and return an error response.
		res.status(500).json({ error: err.message });
	      }
};

module.exports = admin;