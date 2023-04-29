// Import the `jsonwebtoken` library to decode and verify JWT tokens.
const jwt = require("jsonwebtoken");

// Middleware function that checks for a valid JWT token in the request header.
const auth = async (req, res, next) => {
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

module.exports = auth;
