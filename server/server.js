const express = require('express');
const multer = require('multer');
const path = require('path');

const app = express();
const port = 5000;

// Set up storage engine for multer
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/'); // Folder where images will be stored
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname)); // Rename to avoid conflicts
  }
});

const upload = multer({ storage: storage });

// POST endpoint to upload an image
app.post('/upload', upload.single('image'), (req, res) => {
    if (!req.file) {
      return res.status(400).send('No file uploaded');
    }
    const imageUrl = `http://localhost:${port}/images/${req.file.filename}`; // Full URL to the image
    console.log(`image saved! URL: ${imageUrl}`)
    res.send({ message: 'Image uploaded successfully', imageUrl: imageUrl });
});

// GET endpoint to fetch the image
app.get('/images/:filename', (req, res) => {
  const file = path.join(__dirname, 'uploads', req.params.filename);
  res.sendFile(file);
});

// Create uploads directory if it doesn't exist
const fs = require('fs');
const dir = './uploads';
if (!fs.existsSync(dir)) {
  fs.mkdirSync(dir);
}

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
