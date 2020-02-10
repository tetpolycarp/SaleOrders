using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SaintPolycarp.BanhChung.SharedObjectClass;
using SaintPolycarp.BanhChung.SharedObjectClass.RadGrid;
using SaintPolycarp.BanhChung.SharedMethods;

namespace SaintPolycarp.BanhChung
{
    public partial class SendSmsTextMessage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LabelTitle.Text = (string)Request.QueryString["title"];
                TextBoxPhoneNumber.Text = (string)Request.QueryString["phoneNumber"];
                string invoiceNumber = (string)Request.QueryString["invoiceNumber"];
                TextBoxMessageConfirmation.Text = "This is the confirmation for your order. The invoice number is #" + invoiceNumber;
                TextBoxMessageToday.Text = "Friendly reminder: Please come and pickup your order TODAY, " + DateTime.Now.ToString("MM/dd/yyyy") + ". The invoice number is #" + invoiceNumber;
                TextBoxMessageTomorrow.Text = "Friendly reminder: Please come and pickup your order TOMORROW, " + DateTime.Now.AddDays(1).ToString("MM/dd/yyyy") + ". The invoice number is #" + invoiceNumber;
                ButtonSendConfirmation.Enabled = true;
                ButtonSendToday.Enabled = true;
                ButtonSendTomorrow.Enabled = true;
            }
        }

        protected void ButtonSendConfirmation_Click(object sender, EventArgs e)
        {
            try
            {
                ButtonSendConfirmation.Enabled = false;
                ButtonSendConfirmation.BackColor = System.Drawing.Color.Gray;
                SharedMethod.SendSmsTextMessage(TextBoxPhoneNumber.Text, TextBoxMessageConfirmation.Text);
                Response.Write("<script>alert('Confirmed. Message has sent to " + TextBoxPhoneNumber.Text + ". ')</script>");
            }
            catch(Exception ex)
            {
                Response.Write("<script>alert('Confirm in Catch. Message has sent to " + TextBoxPhoneNumber.Text + ". ')</script>");

            }

        }
        protected void ButtonSendToday_Click(object sender, EventArgs e)
        {
            try
            {
                ButtonSendToday.Enabled = false;
                ButtonSendToday.BackColor = System.Drawing.Color.Gray;
                SharedMethod.SendSmsTextMessage(TextBoxPhoneNumber.Text, TextBoxMessageToday.Text);
                Response.Write("<script>alert('Confirmed. Message has sent to " + TextBoxPhoneNumber.Text + ". ')</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Confirm in Catch. Message has sent to " + TextBoxPhoneNumber.Text + ". ')</script>");

            }

        }
        protected void ButtonSendTomorrow_Click(object sender, EventArgs e)
        {
            try
            {
                ButtonSendTomorrow.Enabled = false;
                ButtonSendTomorrow.BackColor = System.Drawing.Color.Gray;
                SharedMethod.SendSmsTextMessage(TextBoxPhoneNumber.Text, TextBoxMessageTomorrow.Text);
                Response.Write("<script>alert('Confirmed. Message has sent to " + TextBoxPhoneNumber.Text + ". ')</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Confirm in Catch. Message has sent to " + TextBoxPhoneNumber.Text + ". ')</script>");

            }

        }
    }
}