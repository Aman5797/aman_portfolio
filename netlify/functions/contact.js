const nodemailer = require('nodemailer');

exports.handler = async (event) => {
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
    'Content-Type': 'application/json',
  };

  if (event.httpMethod === 'OPTIONS') {
    return { statusCode: 200, headers, body: '' };
  }

  if (event.httpMethod !== 'POST') {
    return {
      statusCode: 405,
      headers,
      body: JSON.stringify({ error: 'Method Not Allowed' }),
    };
  }

  try {
    const data = JSON.parse(event.body || '{}');
    const { name, email, subject, message } = data;

    if (!name || !email || !message) {
      return {
        statusCode: 400,
        headers,
        body: JSON.stringify({ error: 'Missing required fields' }),
      };
    }

    if (!process.env.EMAIL_PASS) {
      return {
        statusCode: 500,
        headers,
        body: JSON.stringify({ error: 'Email server not configured' }),
      };
    }

    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: process.env.EMAIL_USER || 'mdaman5797@gmail.com',
        pass: process.env.EMAIL_PASS,
      },
    });

    const now = new Date();
    const dateStr = now.toLocaleDateString('en-IN', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric',
    });
    const timeStr = now.toLocaleTimeString('en-IN', {
      hour: '2-digit',
      minute: '2-digit',
      timeZoneName: 'short',
    });

    const htmlTemplate = `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>New Portfolio Message</title>
</head>
<body style="margin:0;padding:0;background-color:#0f0f1a;font-family:'Segoe UI',Arial,sans-serif;">
  <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#0f0f1a;padding:40px 20px;">
    <tr>
      <td align="center">
        <table width="600" cellpadding="0" cellspacing="0" border="0" style="max-width:600px;width:100%;">

          <!-- Header -->
          <tr>
            <td style="border-radius:16px 16px 0 0;background:linear-gradient(135deg,#7c3aed 0%,#4f46e5 50%,#06b6d4 100%);padding:40px 36px;text-align:center;">
              <p style="margin:0 0 10px 0;font-size:13px;font-weight:600;letter-spacing:3px;text-transform:uppercase;color:rgba(255,255,255,0.7);">Portfolio Contact</p>
              <h1 style="margin:0;font-size:28px;font-weight:700;color:#ffffff;letter-spacing:-0.5px;">New Message Received</h1>
              <p style="margin:12px 0 0 0;font-size:14px;color:rgba(255,255,255,0.75);">Someone reached out via your portfolio contact form</p>
            </td>
          </tr>

          <!-- Body Card -->
          <tr>
            <td style="background-color:#16162a;padding:36px;border-left:1px solid rgba(124,58,237,0.25);border-right:1px solid rgba(124,58,237,0.25);">

              <!-- Sender Info Section -->
              <p style="margin:0 0 20px 0;font-size:11px;font-weight:700;letter-spacing:2px;text-transform:uppercase;color:#7c3aed;">Sender Details</p>

              <!-- Name Row -->
              <table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-bottom:12px;">
                <tr>
                  <td style="background-color:#1e1e35;border-radius:10px;padding:14px 18px;border-left:3px solid #7c3aed;">
                    <p style="margin:0 0 3px 0;font-size:11px;font-weight:600;letter-spacing:1px;text-transform:uppercase;color:rgba(255,255,255,0.45);">Name</p>
                    <p style="margin:0;font-size:16px;font-weight:600;color:#ffffff;">${name}</p>
                  </td>
                </tr>
              </table>

              <!-- Email Row -->
              <table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-bottom:12px;">
                <tr>
                  <td style="background-color:#1e1e35;border-radius:10px;padding:14px 18px;border-left:3px solid #06b6d4;">
                    <p style="margin:0 0 3px 0;font-size:11px;font-weight:600;letter-spacing:1px;text-transform:uppercase;color:rgba(255,255,255,0.45);">Email</p>
                    <a href="mailto:${email}" style="margin:0;font-size:16px;font-weight:600;color:#06b6d4;text-decoration:none;">${email}</a>
                  </td>
                </tr>
              </table>

              <!-- Subject Row -->
              <table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-bottom:28px;">
                <tr>
                  <td style="background-color:#1e1e35;border-radius:10px;padding:14px 18px;border-left:3px solid #4f46e5;">
                    <p style="margin:0 0 3px 0;font-size:11px;font-weight:600;letter-spacing:1px;text-transform:uppercase;color:rgba(255,255,255,0.45);">Subject</p>
                    <p style="margin:0;font-size:16px;font-weight:600;color:#ffffff;">${subject || 'No subject'}</p>
                  </td>
                </tr>
              </table>

              <!-- Divider -->
              <table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-bottom:24px;">
                <tr>
                  <td style="border-top:1px solid rgba(255,255,255,0.08);font-size:0;">&nbsp;</td>
                </tr>
              </table>

              <!-- Message Section -->
              <p style="margin:0 0 16px 0;font-size:11px;font-weight:700;letter-spacing:2px;text-transform:uppercase;color:#7c3aed;">Message</p>
              <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                  <td style="background-color:#1e1e35;border-radius:12px;padding:20px 22px;border:1px solid rgba(124,58,237,0.2);">
                    <p style="margin:0;font-size:15px;line-height:1.8;color:rgba(255,255,255,0.85);white-space:pre-wrap;">${message}</p>
                  </td>
                </tr>
              </table>

            </td>
          </tr>

          <!-- Reply CTA -->
          <tr>
            <td style="background-color:#16162a;padding:0 36px 28px 36px;border-left:1px solid rgba(124,58,237,0.25);border-right:1px solid rgba(124,58,237,0.25);">
              <table cellpadding="0" cellspacing="0" border="0">
                <tr>
                  <td style="border-radius:10px;background:linear-gradient(135deg,#7c3aed,#06b6d4);padding:1px;">
                    <a href="mailto:${email}?subject=Re: ${encodeURIComponent(subject || 'Your Portfolio Message')}" style="display:inline-block;padding:13px 28px;background-color:#16162a;border-radius:9px;font-size:14px;font-weight:600;color:#ffffff;text-decoration:none;letter-spacing:0.3px;">Reply to ${name} &#8594;</a>
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <!-- Footer -->
          <tr>
            <td style="border-radius:0 0 16px 16px;background-color:#0d0d1f;padding:24px 36px;border:1px solid rgba(124,58,237,0.15);border-top:1px solid rgba(255,255,255,0.06);">
              <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                  <td>
                    <p style="margin:0;font-size:12px;color:rgba(255,255,255,0.3);">Received on ${dateStr} at ${timeStr}</p>
                  </td>
                  <td align="right">
                    <p style="margin:0;font-size:12px;color:rgba(255,255,255,0.3);">Aman Ansari &bull; Portfolio</p>
                  </td>
                </tr>
              </table>
            </td>
          </tr>

        </table>
      </td>
    </tr>
  </table>
</body>
</html>
    `;

    await transporter.sendMail({
      from: `"Portfolio Contact" <${process.env.EMAIL_USER || 'mdaman5797@gmail.com'}>`,
      replyTo: `"${name}" <${email}>`,
      to: 'mdaman5797@gmail.com',
      subject: `✉️ ${subject || `New message from ${name}`}`,
      html: htmlTemplate,
    });

    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({ success: true, message: 'Email sent successfully via SMTP' }),
    };
  } catch (error) {
    console.error('Email error:', error);
    return {
      statusCode: 500,
      headers,
      body: JSON.stringify({ error: 'Failed to send email', details: error.message }),
    };
  }
};
