using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Data.SqlClient;
using System.Data.Linq.Mapping;

namespace ConsoleApp1
{
    [Table(Name = "Games")]
    public class Games
    {
        [Column(IsPrimaryKey = true, IsDbGenerated = true)]
        public int id { get; set; }


        [Column]
        public string GameName { get; set; }

        [Column]
        public string GameGenre { get; set; }

        [Column]
        public string Developer { get; set; }

        [Column]
        public int TournamenstAmount { get; set; }

        [Column]
        public int PlayerAmount { get; set; }
    }

    [Table(Name = "PersonalInformation")]
    public class PersonalInformation
    {
        [Column(IsPrimaryKey = true, IsDbGenerated = true)]
        public int id { get; set; }

        [Column]
        public string NickName { get; set; }

        [Column]
        public string FirstName { get; set; }

        [Column]
        public string LastName { get; set; }

        [Column]
        public int AGE { get; set; }

        [Column]
        public int CountryId { get; set; }
    }


    [Table(Name = "Players")]
    public class Players
    {
        [Column(IsPrimaryKey = true, IsDbGenerated=true)]
        public int id { get; set; }

        [Column]
        public string NickName { get; set; }

        [Column]
        public int PrizeMoney { get; set; }

        [Column]
        public int ChampionCount { get; set; }

        [Column]
        public string Game { get; set; }

        [Column]
        public string PlayStyle { get; set; }
    }

    [Table(Name = "Countries")]
    public class Countries
    {
        [Column(IsPrimaryKey = true, IsDbGenerated = true)]
        public int id { get; set; }

        [Column]
        public string Country { get; set; }
    }


}
