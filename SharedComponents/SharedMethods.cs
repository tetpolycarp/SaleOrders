using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading;
using System.Xml;
using System.Xml.XPath;
using System.Web;
using System.Web.UI;
using System.Security.Principal;
using System.Web.Security;
using MongoDB.Bson;
using MongoDB.Driver;
using MongoDB.Driver.Linq;
using Newtonsoft.Json;
using System.Net;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using SaintPolycarp.BanhChung.SharedObjectClass;
using SaintPolycarp.BanhChung.SharedConstansts;
using SaintPolycarp.BanhChung.Google.SharedComponents;

namespace SaintPolycarp.BanhChung.SharedMethods
{
    public static class SharedMethod
    {
        //function for calculating xpath expression
        //get the value of  the real Token 

        public static int RunProcess(string application, string args, ref string standardOuput, string workingdirectory = "", bool redirectStandardError = true)
        {
            //initialize variables
            int returnCode = -1;
            standardOuput = string.Empty;

            //set time to wait running the process of 90 minutes
            const int millisecondWaitTime = 5400000;
            try
            {
                ProcessStartInfo psi = new ProcessStartInfo(application);
                psi.RedirectStandardOutput = true; // always needed so it's not optional
                psi.RedirectStandardError = redirectStandardError;//since redirectorStandardError is optional in some case to avoid deadlock because the stream of standardoutput and standardError are full
                psi.WindowStyle = ProcessWindowStyle.Maximized;

                psi.UseShellExecute = false;
                psi.Arguments = args;

                //Set working directory if exists
                if (workingdirectory != null && workingdirectory.Length > 0)
                {
                    psi.WorkingDirectory = workingdirectory;
                }

                Process process = Process.Start(psi);

                string stdOutput = process.StandardOutput.ReadToEnd();
                string stdError = string.Empty;

                //since redirectorStandardError is optional in some case to avoid deadlock because
                //the stream of standardoutput and standardError are full
                if (redirectStandardError)
                {
                    process.StandardError.ReadToEnd();
                }

                if (stdOutput.Length != 0)
                {
                    standardOuput = stdOutput;
                }

                if (stdError.Length != 0)
                {
                    standardOuput += "</br></br>SCM standard errors from RunProcess():</br>" + stdError;
                }

                //wait max for 60 minutes
                process.WaitForExit(millisecondWaitTime);

                if (process.HasExited)
                {
                    returnCode = process.ExitCode;
                }
                else
                {
                    throw new Exception(string.Format("Exception in RunProcess(): exceed the maximum execution time of {0} minutes", millisecondWaitTime / 60000));
                }
            }
            catch (Exception e)
            {
                throw new Exception(string.Format("Exception in RunProcess(): {0}", e.Message));
            }
            return returnCode;
        }

        public static void SaveTrackingSheet(Finance trackingSheet)
        {
            try
            {
               
                var trackingSheetJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(trackingSheet);
       
                //convert into json readable format
                var trackingSheetJsonContent = JsonConvert.DeserializeObject(trackingSheetJson);

                string fileFullPath = Path.Combine(SharedConstansts.SharedConstants.TRACKING_SHEET_DIRECTORY, DateTime.Now.ToString("yyyy_MM_dd__HH_mm_ss") + "_by_" + trackingSheet.LastUpdateBy + ".json");
                File.WriteAllText(fileFullPath, trackingSheetJsonContent.ToString());
                SharedMethod.WriteLog(trackingSheet.LastUpdateBy + " updated", "SaveTrackingSheet()", SharedConstants.ACTIVITY_LOGS_FILE);
            }
            catch (Exception ex)
            {

            }
        }
        public static Finance GetTrackingSheet()
        {
            Finance trackingSheet = new Finance();
            try
            {
                var directory = new DirectoryInfo(SharedConstansts.SharedConstants.TRACKING_SHEET_DIRECTORY);
                FileInfo latestTrackingSheetFile = directory.GetFiles("*.json")
                                        .OrderByDescending(f => f.LastWriteTime)
                                        .First();
                string trackingSheetContent = File.ReadAllText(latestTrackingSheetFile.FullName);
                trackingSheet = JsonConvert.DeserializeObject<Finance>(trackingSheetContent);
            }
            catch (Exception ex)
            {
                trackingSheet = null;
            }
            return trackingSheet;
        }
        public static void SaveInvoice(OrderInvoice invoice)
        {
            try
            {
                //remove the element in json
                /*
                var properties = invoice.GetType().GetProperties().Where(x => x.Name != "Id");
                var response = new Dictionary<string, object>();

                 foreach (var prop in properties)
                 {
                     var propname = prop.Name;
                     response[propname] = prop.GetValue(invoice); ;
                 }
                 var invoiceJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(response);
                 */

                var invoiceJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(invoice);

                //convert into json readable format
                var invoiceJsonContent = JsonConvert.DeserializeObject(invoiceJson);
                
                string fileDirectory = Path.Combine(SharedConstansts.SharedConstants.INVOICE_DIRECTORY, invoice.InvoiceNumber);
                if (!Directory.Exists(fileDirectory))
                    Directory.CreateDirectory(fileDirectory);

                
                string fileFullPath = Path.Combine(fileDirectory, DateTime.Now.ToString("yyyy_MM_dd__HH_mm_ss") + "_by_" + invoice.LastUpdateBy + ".json");
                File.WriteAllText(fileFullPath, invoiceJsonContent.ToString());
                SharedMethod.WriteLog(invoice.LastUpdateBy + " updated invoice " + invoice.InvoiceNumber, "SaveInvoice()", SharedConstants.ACTIVITY_LOGS_FILE);
            }
            catch(Exception ex)
            {

            }

        }
        public static OrderInvoice GetInvoice(string invoiceNumber)
        {
            OrderInvoice invoice = new OrderInvoice();
            try
            {
                string invoiceDirectory = Path.Combine(SharedConstansts.SharedConstants.INVOICE_DIRECTORY, invoiceNumber);
                var directory = new DirectoryInfo(Path.Combine(SharedConstansts.SharedConstants.INVOICE_DIRECTORY, invoiceNumber));
                FileInfo latestInvoiceFile = directory.GetFiles("*.json")
                                        .OrderByDescending(f => f.LastWriteTime)
                                        .First();
                string invoiceContent = File.ReadAllText(latestInvoiceFile.FullName);


                invoice = JsonConvert.DeserializeObject<OrderInvoice>(invoiceContent);

            }
            catch (Exception ex)
            {
                return null;
            }
            return invoice;
        }
        public static string GetChangeHistory(string invoiceNumber)
        {
            string invoiceChangeHistory = "Change history:";
            try
            {
                
                var directory = new DirectoryInfo(Path.Combine(SharedConstansts.SharedConstants.INVOICE_DIRECTORY, invoiceNumber));
                //get the list of all the file
                var files = directory.GetFiles("*.json").OrderBy(f => f.LastWriteTime);
                foreach(FileInfo file in files)
                {
                    invoiceChangeHistory += "<br />\r\n" + Environment.NewLine + file.Name;
                }
                invoiceChangeHistory += "<br />\r\n" + Environment.NewLine;
            }
            catch(Exception ex)
            {
                return "";
            }
            return invoiceChangeHistory;
        }
        public static List<OrderInvoice> GetInvoices()
        {
            List<OrderInvoice> invoices = new List<OrderInvoice>();
            var directory = new DirectoryInfo(SharedConstansts.SharedConstants.INVOICE_DIRECTORY);
            
            //parse through each of the folder to get the invoices
            foreach(var dir in directory.GetDirectories("*", SearchOption.TopDirectoryOnly))
            {
                try
                {
                    //assuming the name of the folder is the invoice number
                    //then get the invoice
                    invoices.Add(GetInvoice(dir.Name));
                }
                catch(Exception ex)
                {

                }
            }

            return invoices;
        }

        public static void UpdateTotalPickupToInventoryInGoogleSheet()
        {
            //https://docs.google.com/spreadsheets/d/1bD48A5dwSs2vRaLGsWmD9w-cE6KYS0bFxyypxEJLLMQ/edit#gid=0
            string spreadsheetId = "1bD48A5dwSs2vRaLGsWmD9w-cE6KYS0bFxyypxEJLLMQ";
            string spreadsheetName = "BanhChungInventory";
            string updatedRange = "G3:G4";
     

            //expired date to make sure future changes won't update the archive google sheet
            DateTime expiredDate = new DateTime(2020, 2, 1, 0, 0, 0);

            //only need to execute while still before the expired Date
            if (DateTime.Compare(DateTime.Now, expiredDate) < 0)
            {
                int chungPickedup = 0;
                int tetPickedup = 0;
                //parse through all the invoices and get the pickup items
                List<OrderInvoice> orderInvoices = SharedMethod.GetInvoices();
                //parse through each of the invoice
                foreach (OrderInvoice orderInvoice in orderInvoices)
                {
                    try
                    {
                        //for each of the invoice, parse through each of the order/sale item to calculate the number
                        foreach (var orderSaleItem in orderInvoice.OrderSaleItems)
                        {
                            //only care about Banh Chung and Banh Tet
                            if (orderSaleItem.SaleItem.Contains("Chưng") || orderSaleItem.SaleItem.Contains("Tét"))
                            {
                                if (orderSaleItem.PickedUp.ToUpper().Equals("YES"))
                                {
                                    int pickedup = Convert.ToInt16(orderSaleItem.Quantity);
                                    if(orderSaleItem.SaleItem.Contains("Chưng"))
                                    {
                                        chungPickedup += pickedup;
                                    }
                                    else if (orderSaleItem.SaleItem.Contains("Tét"))
                                    {
                                        tetPickedup += pickedup;
                                    }
                                }
                            }

                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
            


                //Setting up for google value
                List<IList<Object>> objNewRecords = new List<IList<Object>>();
                IList<Object> chungObj = new List<Object>();
                chungObj.Add(chungPickedup); // the number above is Banh Chung
                objNewRecords.Add(chungObj);

                IList<Object> tetObj = new List<Object>();
                tetObj.Add(tetPickedup); // the number below is Bant Tet
                objNewRecords.Add(tetObj);


                Methods.UpdateRangeValueInSheet(spreadsheetId, spreadsheetName, updatedRange, objNewRecords);
            }
        }
    
        public static List<SaleItem> GetSaleItems()
        {
            List<SaleItem> items = new List<SaleItem>();
            try
            {
                string itemsContent = File.ReadAllText(SharedConstansts.SharedConstants.SALE_ITEMS_FILE);
                items = JsonConvert.DeserializeObject<List<SaleItem>>(itemsContent);
            }
            catch(Exception ex)
            {

            }

            return items;
        }

        //The problem is that if you redirect StandardOutput and/or StandardError the internal buffer can become full. Whatever order you use, there can be a problem:
        //If you wait for the process to exit before reading StandardOutput the process can block trying to write to it, so the process never ends.
        //If you read from StandardOutput using ReadToEnd then your process can block if the process never closes StandardOutput (for example if it never terminates, or if it is blocked writing to StandardError).
        //The solution is to use asynchronous reads to ensure that the buffer doesn't get full. To avoid any deadlocks and collect up all output from both StandardOutput and StandardError
        public static int RunProcessUsingAsyncReads(string application, string args, ref string standardOuput, string workingdirectory = "")
        {
            //initialize variables
            int returnCode = -1;
            standardOuput = string.Empty;

            //set time to wait running the process of 90 minutes
            const int millisecondWaitTime = 5400000;
            try
            {
                using (Process process = new Process())
                {
                    process.StartInfo.FileName = application;
                    process.StartInfo.Arguments = args;
                    process.StartInfo.UseShellExecute = false;
                    process.StartInfo.RedirectStandardOutput = true;
                    process.StartInfo.RedirectStandardError = true;

                    StringBuilder output = new StringBuilder();
                    StringBuilder error = new StringBuilder();

                    //use multi threading to add output and error into a temporary string builder when there are new added event of output or error
                    //then also reset the buffer so it won't be full                 
                    using (AutoResetEvent outputWaitHandle = new AutoResetEvent(false))
                    using (AutoResetEvent errorWaitHandle = new AutoResetEvent(false))
                    {
                        process.OutputDataReceived += (sender, e) =>
                        {
                            if (e.Data == null)
                            {
                                outputWaitHandle.Set();
                            }
                            else
                            {
                                output.AppendLine(e.Data);
                            }
                        };
                        process.ErrorDataReceived += (sender, e) =>
                        {
                            if (e.Data == null)
                            {
                                errorWaitHandle.Set();
                            }
                            else
                            {
                                error.AppendLine(e.Data);
                            }
                        };

                        process.Start();

                        process.BeginOutputReadLine();
                        process.BeginErrorReadLine();

                        if (process.WaitForExit(millisecondWaitTime) &&
                            outputWaitHandle.WaitOne(millisecondWaitTime) &&
                            errorWaitHandle.WaitOne(millisecondWaitTime))
                        {
                            // Process completed. Check process.ExitCode here.
                            if (output.ToString().Length != 0)
                            {
                                standardOuput = output.ToString();
                            }

                            if (error.ToString().Length != 0)
                            {
                                standardOuput += "\nSCM standard errors from RunProcessUsingAsyncReads():" + error.ToString();
                            }
                            returnCode = process.ExitCode;
                        }
                        else
                        {
                            throw new Exception(string.Format("Exception in RunProcessUsingAsyncReads(): exceed the maximum execution time of {0} minutes", millisecondWaitTime / 60000));
                        }
                    }
                }
            }


            catch (Exception e)
            {
                throw new Exception(string.Format("Exception in RunProcess(): {0}", e.Message));
            }
            return returnCode;
        }

        //Linux and Jenkins functions

        public static void SendEmail(string distro, string subject, string body, string from = "", string cc = "")
        {
            try
            {

                if (string.IsNullOrEmpty(distro) || !distro.Contains("@"))
                {
                    throw new Exception(string.Format("Email Distro is empty or null"));
                }
                else if (string.IsNullOrEmpty(subject))
                {
                    throw new Exception(string.Format("Email Subject is empty or null"));
                }
                else if (string.IsNullOrEmpty(body))
                {
                    throw new Exception(string.Format("Email Body is empty or null"));
                }


                //SMTP emails work well with "," than ";" because if we use ";" w/o the space in the front, smtp will fail.
                //for example: "chau.nguyen@mitchell.com;wayne.samshima@mitchell.com"
                //therefore, let replace all ";" with ","
                distro = distro.Replace(';', ',');


                SmtpClient objSmtp = new SmtpClient("mail.mitchell.com");
                objSmtp.UseDefaultCredentials = true;
                MailMessage objMsg = new MailMessage();
                if (from == "")
                    objMsg.From = new MailAddress("noreply_SoftwareConfigurationManagement@mitchell.com");
                else
                    objMsg.From = new MailAddress(from);

                objMsg.To.Add(distro);

                if (cc != "")
                {
                    objMsg.CC.Add(cc);
                }
                objMsg.Subject = subject;
                objMsg.IsBodyHtml = true;
                objMsg.Body = body;
                objSmtp.Send(objMsg);

            }
            catch (Exception e)
            {
                throw new Exception(string.Format("Exception in SendEmail(): {0}", e.Message));
            }
        }

        public static void SendSmsTextMessage(string phoneNumber, string message)
        {
            try
            {
                var fromEmail = "btvpolycarp@gmail.com";
                var fromEmailPwd = "polycarp14";
                // Credentials
                var credentials = new NetworkCredential(fromEmail, fromEmailPwd);

                // Mail message
                var mail = new MailMessage()
                {
                    From = new MailAddress(fromEmail),
                    Subject = "Reminder to " + phoneNumber,
                    Body = "Gian Hang Tet 2020 - " + message
                };

                mail.To.Add(new MailAddress(phoneNumber + "@txt.att.net")); //at&t
                mail.To.Add(new MailAddress(phoneNumber + "@vtext.com")); //verizon
                mail.To.Add(new MailAddress(phoneNumber + "@tmomail.net")); //t-mobile
                mail.To.Add(new MailAddress(phoneNumber + "@messaging.sprintpcs.com")); //sprint
                mail.To.Add(new MailAddress(phoneNumber + "@vmobl.com")); //virgin mobile
                mail.To.Add(new MailAddress(phoneNumber + "@messaging.nextel.com")); //Nextel
                mail.To.Add(new MailAddress(phoneNumber + "@myboostmobile.com")); //Boost
                mail.To.Add(new MailAddress(phoneNumber + "@message.alltel.com")); //Alltel

                //send a backup
                mail.CC.Add(new MailAddress(fromEmail)); //send a backup

                // Smtp client
                var client = new SmtpClient()
                {
                    Port = 587,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    UseDefaultCredentials = false,
                    Host = "smtp.gmail.com",
                    EnableSsl = true,
                    Credentials = credentials
                };

                // Send it...         
                client.Send(mail);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in sending email: " + ex.Message);
                Console.ReadKey();
                return;
            }

            Console.WriteLine("Email sccessfully sent");
            Console.ReadKey();
        }
        //security functions
        public static string GetUser()
        {
            HttpContext httpContext = HttpContext.Current;
            System.Security.Principal.WindowsIdentity winIdentity = (System.Security.Principal.WindowsIdentity)httpContext.User.Identity;
            string userIdentity = winIdentity.Name;
            return userIdentity;
        }

        public static void WriteLog(string message, string prefix, string logFile)
        {
            //maximum size for log file in bytes 
            long MAX_SIZE = 1000000; //~1MB size
            try
            {
                if (File.Exists(logFile))
                {
                    //verify the size of the log file (in bytes), if it's too big, then delete it
                    var length = new System.IO.FileInfo(logFile).Length;
                    if (length > MAX_SIZE)
                    {
                        File.Delete(logFile);
                    }
                }

                //if log file not already created
                if (!File.Exists(logFile))
                {
                    FileInfo file = new FileInfo(logFile);

                    //now create log file and the directory if it doesn't exist
                    file.Directory.Create();
                    using (StreamWriter sw = File.CreateText(logFile)) //create text for the file
                    {
                        sw.WriteLine(string.Format("*log* {0} - Starting new log.... <br />", DateTime.Now.ToString("yyyy/MM/dd - HH:mm:ss")));
                        sw.WriteLine(string.Format("*log* {0} - {1} - {2} <br />", DateTime.Now.ToString("yyyy/MM/dd - HH:mm:ss"), prefix, message));
                    }
                }
                //if the log already created, append the text
                else
                {
                    try
                    {
                        using (StreamWriter sw = File.AppendText(logFile))
                        {
                            sw.WriteLine(string.Format("*log* {0} - {1} - {2} <br />", DateTime.Now.ToString("yyyy/MM/dd - HH:mm:ss"), prefix, message));
                        }
                    }
                    catch (IOException ioex)
                    {
                        //if when writting into the log file with other process accessing it, wait and give it another try.
                        //Do not put this into the loop because it my impact performance of TFS.
                        Thread.Sleep(5000); //5 seconds
                        using (StreamWriter sw = File.AppendText(logFile))
                        {
                            sw.WriteLine(string.Format("*log* {0} - {1} - {2) <br />", DateTime.Now.ToString("yyyy/MM/dd - HH:mm:ss"), prefix, message));
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("*log* {0} - {1} - Error when writting message \"{2}\" - {3} <br />", DateTime.Now.ToString("yyyy/MM/dd - HH:mm:ss"), prefix, message, ex.Message));
            }
        }

     
        public static void AddListOfInvoicesToMenu(RadMenu commonMenu, bool isMobile)
        {
            //refresh the menu but empty all the items
            commonMenu.Items[2].Items.Clear(); //index 2 because the first top menu (View Invoices)



            //******************Create the data row first *********************
            List<OrderInvoice> orderInvoices = SharedMethod.GetInvoices();

            foreach (OrderInvoice orderInvoice in orderInvoices)
            {
                RadMenuItem invoiceItem = new RadMenuItem();
                string createdBy = "";
                if (!string.IsNullOrEmpty(orderInvoice.CreatedBy))
                {
                    string[] createdBySplit = orderInvoice.CreatedBy.Split(new string[] { " on " }, StringSplitOptions.None);
                    if (createdBySplit.Count() > 0)
                    {
                        createdBy = " [" + createdBySplit[0].Trim() + "]";
                    }

                }
                if (orderInvoice.InvoiceType.Equals("Complex"))
                {
                    invoiceItem.Text = "#" + orderInvoice.InvoiceNumber + " - " + orderInvoice.CustomerName + "**" + createdBy;
                }
                else
                {
                    invoiceItem.Text = "#" + orderInvoice.InvoiceNumber + " - " + orderInvoice.CustomerName + createdBy;
                }

                //if Mobile, then call the mobile page
                if (isMobile)
                {
                    invoiceItem.NavigateUrl = "~/InvoiceMobile?InvoiceNumber=" + orderInvoice.InvoiceNumber;
                }
                else
                {
                    invoiceItem.NavigateUrl = "~/Invoice?InvoiceNumber=" + orderInvoice.InvoiceNumber;
                }
                commonMenu.Items[2].Items.Add(invoiceItem); //add into View Invoices Menu
            }

        }

        public static void RedirectIfOnMobileDevice(HttpRequest request, HttpResponse response)
        {

            string device_info = GetMobileDevice(request, response);
           //if found mobile device, then redirect
           if (!string.IsNullOrEmpty(device_info))
           {
               response.Redirect("DefaultMobile.aspx?device_info=" + device_info);
           }

        }
        public static bool IsMobileDevice(HttpRequest request, HttpResponse response)
        {
            string device_info = GetMobileDevice(request, response);
            //if found mobile device, then redirect
            if (!string.IsNullOrEmpty(device_info))
            {
                return true;
            }
            return false;
        }

        public static string GetMobileDevice(HttpRequest request, HttpResponse response)
        {
            string userAgent = request.ServerVariables["HTTP_USER_AGENT"];
            Regex OS = new Regex(@"(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino", RegexOptions.IgnoreCase | RegexOptions.Multiline);
            Regex device = new Regex(@"1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-", RegexOptions.IgnoreCase | RegexOptions.Multiline);
            string device_info = string.Empty;
            if (OS.IsMatch(userAgent))
            {
                device_info = OS.Match(userAgent).Groups[0].Value;
            }
            if (device.IsMatch(userAgent.Substring(0, 4)))
            {
                device_info += device.Match(userAgent).Groups[0].Value;
            }

            return device_info;
        }
    }

}