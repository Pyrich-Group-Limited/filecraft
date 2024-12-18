using MimeKit;
using MailKit.Net.Smtp;
using MailKit.Security;
using System;
using System.IO;
using System.Threading.Tasks;



namespace DocumentManagement.Helper
{
    public class EmailHelper
    {
    
        //public static void SendEmail(SendEmailSpecification sendEmailSpecification)
        //{
        //    MailMessage message = new MailMessage()
        //    {
        //        Sender = new MailAddress(sendEmailSpecification.FromAddress),
        //        From = new MailAddress(sendEmailSpecification.FromAddress),
        //        Subject = sendEmailSpecification.Subject,
        //        IsBodyHtml = true,
        //        Body = sendEmailSpecification.Body,
        //    };

        //    if (sendEmailSpecification.Attechments.Count > 0)
        //    {
        //        Attachment attach;
        //        foreach (var file in sendEmailSpecification.Attechments)
        //        {
        //            var ms = new MemoryStream(file.Src);
        //            attach = new Attachment(ms, file.Name, file.FileType);
        //            attachments.Add(ms);
        //            message.Attachments.Add(attach);
        //        }
        //    }
        //    sendEmailSpecification.ToAddress.Split(",").ToList().ForEach(toAddress =>
        //    {
        //        message.To.Add(new MailAddress(toAddress));
        //    });
        //    if (!string.IsNullOrEmpty(sendEmailSpecification.CCAddress))
        //    {
        //        sendEmailSpecification.CCAddress.Split(",").ToList().ForEach(ccAddress =>
        //        {
        //            message.CC.Add(new MailAddress(ccAddress));
        //        });
        //    }

        //    SmtpClient smtp = new SmtpClient()
        //    {
        //        Port = sendEmailSpecification.Port,
        //        Host = sendEmailSpecification.Host,
        //        EnableSsl = sendEmailSpecification.IsEnableSSL,
        //        UseDefaultCredentials = false,
        //        Credentials = new NetworkCredential(sendEmailSpecification.UserName, sendEmailSpecification.Password),
        //        DeliveryMethod = SmtpDeliveryMethod.Network,
        //        Timeout = 20000
        //    };
        //    smtp.Send(message);
        //    if (attachments.Count() > 0)
        //    {
        //        foreach (var attachment in attachments)
        //        {
        //            try
        //            {
        //                attachment.Dispose();
        //            }
        //            catch
        //            {
        //            }
        //        }
        //    }

        //}


       public static async Task<bool> SendEmail(SendEmailSpecification sendEmailSpecification)
        {
            try
            {
                var message = new MimeMessage();

                // Sender information
                message.From.Add(new MailboxAddress(sendEmailSpecification.FromName?? sendEmailSpecification.UserName, sendEmailSpecification.FromAddress));

                // Recipient information
                message.To.Add(new MailboxAddress("Recipient Name", sendEmailSpecification.ToAddress));

                // Subject
                message.Subject = sendEmailSpecification.Subject;

                if (sendEmailSpecification.Attechments.Count > 0)
                {

                    var body = new TextPart("html")
                    {
                        Text = sendEmailSpecification.Body
                    };

                    // Create a multipart email to hold both the body and attachment
                    var multipart = new Multipart("mixed");
                    multipart.Add(body); // Add the body part
                    foreach (var file in sendEmailSpecification.Attechments)
                    {
                        var ms = new MemoryStream(file.Src);
                        var attachment = new MimePart("application", "octet-stream")
                        {
                            Content = new MimeContent(ms),
                            ContentDisposition = new ContentDisposition(ContentDisposition.Attachment),
                            ContentTransferEncoding = ContentEncoding.Base64,
                            FileName = file.Name,
                        };

                        multipart.Add(attachment);
                    }
                
                    message.Body = multipart;
                }
                else
                {
                    message.Body = new TextPart("html")
                    {
                        Text = sendEmailSpecification.Body
                    };
                }

                // Set the email body to the multipart content
              

                // SMTP server configuration
                using (var client = new SmtpClient())
                {
                    await client.ConnectAsync(sendEmailSpecification.Host, sendEmailSpecification.Port, SecureSocketOptions.Auto); // SMTP server and port
                    await client.AuthenticateAsync(sendEmailSpecification.UserName, sendEmailSpecification.Password); // SMTP credentials

                    // Send the email
                    client.Timeout = 30000;
                    await client.SendAsync(message);               
                    await client.DisconnectAsync(true); // Disconnect from the server
                }

                return true;
            }
            catch 
            {
                return false;
            }
        }

    }


}
