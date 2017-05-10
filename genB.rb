text = ""
shitfuck = ["IsThird", "Alt", "DeleteType"]
# for x in shitfuck
 # varB = "B" + x.to_s
 varB = "DeleteType"
 # varB = x
 typeB = "short"
 # template = %Q[
 #        [XmlIgnore]
 #        [NotColumn]
 #        private #{typeB}? _#{varB};

 #        [XmlElement("#{varB}")]
 #        [NotColumn]
 #        public string #{varB}String
 #        {
 #            get
 #            {
 #                if (!_#{varB}.HasValue)
 #                {
 #                    return null;
 #                }
 #                else
 #                {
 #                    return _#{varB}.ToString();
 #                }
 #            }
 #            set { }
 #        }

 #        [XmlIgnore]
 #        [Column, Nullable]
 #        public #{typeB}? #{varB}
 #        {
 #            get { return _#{varB}; }
 #            set { _#{varB} = value; }
 #        }
 # ]

 text << template
# end
File.open('d:\rubies\fooB.txt', 'w:windows-1251') {|f| f.write(text) }
