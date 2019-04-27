const express = require('express');
const morgan = require('morgan');
const cors = require('cors');
const compression = require('compression');

const PORT = process.env.PORT || 3333;

const app = express();

app.use(cors());
app.use(morgan('combined'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(compression());

app.listen(PORT, () => console.log('Server running at port %d', PORT));
