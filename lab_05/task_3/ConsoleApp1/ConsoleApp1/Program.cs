using System;
using System.Xml;
using System.Xml.Schema;

namespace ValidateCS
{
    class Class1
    {
        static void Main(string[] args)
        {
            XmlSchemaCollection sc = new XmlSchemaCollection();
            sc.Add("", "../../../../visual_studio_schema_test.xsd");

            // Create a validating reader object
            XmlTextReader tr = new XmlTextReader("../../../../test_xml.xml");
            //XmlTextReader tr = new XmlTextReader("../../../../xml_test_wrong_atrib.xml");
            //XmlTextReader tr = new XmlTextReader("../../../../xml_test_wrong_root.xml");
            XmlValidatingReader vr = new XmlValidatingReader(tr);

            // Specify the type of validation required
            vr.ValidationType = ValidationType.Schema;

            // Tell the validating reader to use the schema collection
            vr.Schemas.Add(sc);

            // Register a validation event handler method
            vr.ValidationEventHandler += new ValidationEventHandler(MyHandler);

            // Read and validate the XML document
            try
            {
                int num = 0;
                while (vr.Read())
                {

                    if (vr.NodeType == XmlNodeType.Element &&
                       vr.LocalName == "Games")
                    {
                        num++;

                        vr.MoveToFirstAttribute();
                        Console.WriteLine(vr.Value);
                        vr.MoveToNextAttribute();
                        Console.WriteLine(vr.Value);
                        vr.MoveToNextAttribute();
                        Console.WriteLine(vr.Value);
                        vr.MoveToNextAttribute();
                        Console.WriteLine(vr.Value);
                        vr.MoveToNextAttribute();
                        Console.WriteLine(vr.Value);

                        vr.MoveToElement();

                    }

                }

                Console.WriteLine("Number of strings: " + num + "\n");
            }
            catch (XmlException ex)
            {
                Console.WriteLine("XMLException occurred: " + ex.Message);
            }
            finally
            {
                vr.Close();
            }
        }

        // Validation event handler method
        public static void MyHandler(object sender, ValidationEventArgs e)
        {
            Console.WriteLine("Validation Error: " + e.Message);
        }
    }
}
