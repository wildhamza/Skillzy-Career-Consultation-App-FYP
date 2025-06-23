const mappedSkills = [
  {
    "Database Fundamentals": [
      "Relational Databases (MySQL, PostgreSQL)",
      "NoSQL Databases (MongoDB, Cassandra)",
      "SQL Query Optimization",
      "Database Design & Modeling",
      "Data Backup & Recovery"
    ]
  },
  {
    "Computer Architecture": ["Instruction Set Architecture", "Memory Hierarchy", "CPU Scheduling", "Parallel Processing", "I/O Systems"]
  },
  {
    "Distributed Computing Systems": ["Cloud Computing", "Microservices Architecture", "Load Balancing", "Distributed Databases", "Fault Tolerance"]
  },
  {
    "Cyber Security": [
      "Network Security",
      "Application Security",
      "Penetration Testing",
      "Encryption Techniques",
      "Security Compliance (e.g., GDPR, HIPAA)"
    ]
  },
  {
    Networking: ["Network Protocols (TCP/IP, HTTP)", "Routing & Switching", "Network Configuration", "Firewall & VPN", "Network Monitoring Tools"]
  },
  {
    "Software Development": ["Web Development", "Backend Development", "Mobile App Development", "Desktop App Development", "API Development"]
  },
  {
    "Programming Skills": [
      "Object-Oriented Programming",
      "Functional Programming",
      "Data Structures & Algorithms",
      "Version Control (Git)",
      "Debugging & Testing"
    ]
  },
  {
    "Project Management": [
      "Agile Methodology",
      "Scrum Framework",
      "Risk Management",
      "Team Collaboration Tools (Jira, Trello)",
      "Project Planning & Estimation"
    ]
  },
  {
    "Computer Forensics Fundamentals": [
      "Digital Evidence Handling",
      "File System Analysis",
      "Incident Response",
      "Forensic Tools (EnCase, FTK)",
      "Chain of Custody"
    ]
  },
  {
    "Technical Communication": [
      "Writing Technical Documentation",
      "Report Writing",
      "Creating User Manuals",
      "Diagrams & Flowcharts",
      "Explaining Complex Concepts Simply"
    ]
  },
  {
    "AI ML Specialist": [
      "Machine Learning Algorithms",
      "Deep Learning",
      "Natural Language Processing",
      "Model Training & Evaluation",
      "Data Preprocessing"
    ]
  },
  {
    "Software Engineering": [
      "Software Development Life Cycle (SDLC)",
      "Requirement Analysis",
      "System Design",
      "Code Quality & Standards",
      "Testing & Maintenance"
    ]
  },
  {
    "Business Analysis": ["Stakeholder Requirements Gathering", "Use Case Modeling", "Process Improvement", "SWOT Analysis", "Feasibility Study"]
  },
  {
    "Communication skills": ["Verbal Communication", "Written Communication", "Presentation Skills", "Active Listening", "Conflict Resolution"]
  },
  {
    "Data Science": ["Data Analysis", "Data Visualization", "Statistical Modeling", "Big Data Tools (Spark, Hadoop)", "Machine Learning Integration"]
  },
  {
    "Troubleshooting skills": [
      "Root Cause Analysis",
      "System Diagnostics",
      "Error Logging & Interpretation",
      "Hardware Troubleshooting",
      "Performance Optimization"
    ]
  },
  {
    "Graphics Designer": [
      "UI/UX Design",
      "Logo & Branding Design",
      "Adobe Creative Suite (Photoshop, Illustrator)",
      "Wireframing & Prototyping",
      "Typography & Color Theory"
    ]
  }
];

export const getMappedSkills = (skill: string) => {
  const mappedSkill = mappedSkills.find((item) => Object.keys(item)[0] === skill);
  if (mappedSkill) {
    return mappedSkill[skill];
  }
  return [];
};

export default getMappedSkills;
