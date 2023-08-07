const express = require('express');
const app = express();

app.use(express.json());

// In-memory data store for tasks
let tasks = [];
let taskId = 1;

// Add a new task
app.post('/tasks', (req, res) => {
  const { title } = req.body;
  if (!title) {
    return res.status(400).json({ error: 'Task Title is required.' });
  }

  const task = { id: taskId, title };
  tasks.push(task);
  taskId++;

  return res.status(201).json(task);
});

// all tasks
app.get('/tasks', (req, res) => {
  return res.json(tasks);
});

// Delete
app.delete('/tasks/:id', (req, res) => {
  const taskId = parseInt(req.params.id);
  const index = tasks.findIndex((task) => task.id === taskId);

  if (index === -1) {
    return res.status(404).json({ error: 'Task not found.' });
  }

  tasks.splice(index, 1);
  return res.json({ message: 'Task deleted successfully.' });
});

// "/"
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/index.html');
});

const port = 3000;
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
