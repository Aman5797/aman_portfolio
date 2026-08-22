// api/contact.js - Vercel / Netlify / Node.js Serverless Function
// Install nodemailer in your backend project: npm install nodemailer

const nodemailer = require('nodemailer');

module.exports = async (req, res) => {
  // Set CORS headers so your Flutter Web app can call this endpoint
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');

  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { name, email, subject, message } = req.body || {};

    if (!name || !email || !message) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    // Configure your own SMTP Transporter (e.g., Gmail SMTP with App Password)
    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: process.env.EMAIL_USER || 'mdaman5797@gmail.com',
        pass: process.env.EMAIL_PASS, // Your Gmail App Password stored securely in Environment Variables
      },
    });

    // Mail options
    const mailOptions = {
      from: `"${name}" <${process.env.EMAIL_USER || 'mdaman5797@gmail.com'}>`,
      replyTo: email,
      to: 'mdaman5797@gmail.com',
      subject: subject || `New Portfolio Message from ${name}`,
      html: `
        <h3>New Contact Form Message</h3>
        <p><strong>Name:</strong> ${name}</p>
        <p><strong>Email:</strong> ${email}</p>
        <p><strong>Subject:</strong> ${subject || 'N/A'}</p>
        <br/>
        <p><strong>Message:</strong></p>
        <p style="white-space: pre-wrap;">${message}</p>
      `,
    };

    await transporter.sendMail(mailOptions);

    return res.status(200).json({ success: true, message: 'Email sent successfully' });
  } catch (error) {
    console.error('Email send error:', error);
    return res.status(500).json({ error: 'Failed to send email' });
  }
};
