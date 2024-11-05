import express from 'express';
import cors from 'cors';
import { PrismaClient } from '@prisma/client';
import { hash, compare } from 'bcrypt-ts';

const app = express();
const PORT = process.env.PORT || 8080;
const prisma = new PrismaClient()

app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: true }));

//HTTP requests
app.get('/', (req, res) => {
  res.send('Hello World!')
});

app.post('/register', async (req, res) => {
  const {username, password} = req.body;
  const userExist = await checkForUsername(username);

  if (!userExist) {
    const saltedHash = await hashPassword(password);
    if (saltedHash) {
      const userCreated = await addUser(username, saltedHash);
      res.status(201).send("User created");
    } else {
      res.status(500).send("Error hashing.");
    }


  } else {
    res.status(400).send("User already exists.")
  }
});

app.post('/login', async (req, res) => {
  const {username, password} = req.body;
  const userFound = await checkForUsername(username);

  if (userFound) {
    const saltedHash = userFound.salted_hash;
    const authCheck = await verifyPassword(password, saltedHash);

    if (authCheck) {
      res.status(200).send({id: userFound.id})
    } else {
      res.status(401).send("Authentication failed")
    }
  } else {
    res.status(404).send("User not found");
  }
});

app.post('/save-drawing', (req, res) => {
  const {title, content, user_id} = req.body;
  const newDrawing = storeDrawing(title, content, user_id);
  if (newDrawing) {
    res.status(201).send(newDrawing);
  } else {
    res.status(500).send("Error adding drawing.");
  }
});


//functions
async function addUser(username: string, saltedHash: string) {
  await prisma.site_user.create({
    data: {
      username: username,
      salted_hash: saltedHash
    }
  });
  return await checkForUsername(username);
}

async function hashPassword(origPass: string) {
  const saltRounds = 10;
  try {
    const hashedPass: string = await hash(origPass, saltRounds);
    return hashedPass;
  } catch (err) {
    console.error('Verification error:', err);
  }
}

async function verifyPassword(origPass: string, hashedPass: string) {
  return await compare(origPass, hashedPass);
}

async function checkForUsername(username: string) {
  return await prisma.site_user.findUnique({
    where: {
      username: username,
    },
  })
}

async function storeDrawing(title: string, content: string, userId: number) {
  try {
    const newDrawing = await prisma.drawing.create({
      data: {
        title: title,
        content: content,
        user_id: userId
      }
    })
    return newDrawing;
  } catch (err) {
    console.error('Error adding drawing: ', err);
  }
}

app.listen(PORT, () =>{
  console.log(`Express server is up and running at http://localhost:${PORT}`);
});