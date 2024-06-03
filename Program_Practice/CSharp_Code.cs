using System;
using System.Data.SqlClient;

namespace YourNamespace
{
    public class InsertData
    {
        public void InsertDataIntoDatabase(string date, string amountInst, string share, string amountNow, string profitDay, string lossDay, string profitAll, string lossAll)
        {
            // Connection string to your local SQL Server database
			string connectionString = "Server=PAVANK/SQLSERVER;Database=PavanK;Integrated Security=True;";
            string connectionString = "Data Source=YourDataSource;Initial Catalog=YourDatabase;Integrated Security=True";

            // SQL query to insert data into the table
            string query = @"INSERT INTO YourTableName (date, amount_INST, share, amount_NOW, Profit_Day, Loss_Day, Profit_All, Loss_All) 
                             VALUES (@Date, @AmountInst, @Share, @AmountNow, @ProfitDay, @LossDay, @ProfitAll, @LossAll)";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // Open the connection
                    connection.Open();

                    // Create a SqlCommand object
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters to the command
                        command.Parameters.AddWithValue("@Date", date);
                        command.Parameters.AddWithValue("@AmountInst", amountInst);
                        command.Parameters.AddWithValue("@Share", share);
                        command.Parameters.AddWithValue("@AmountNow", amountNow);
                        command.Parameters.AddWithValue("@ProfitDay", profitDay);
                        command.Parameters.AddWithValue("@LossDay", lossDay);
                        command.Parameters.AddWithValue("@ProfitAll", profitAll);
                        command.Parameters.AddWithValue("@LossAll", lossAll);

                        // Execute the command
                        command.ExecuteNonQuery();
                    }
                }

                Console.WriteLine("Data inserted successfully.");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
        }
    }
}
