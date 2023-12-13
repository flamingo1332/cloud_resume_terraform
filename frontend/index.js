import React from 'react';
import { createRoot } from 'react-dom/client';
import { useEffect, useState } from "react";
import axios from "axios";
import ReactCV from 'react-cv';
import { CVData } from './data';

const App = () => {
  // const [visitor, setVisitor] = useState(0);
  const [cvData, setCvData] = useState(CVData);


  useEffect(() => {
    getVisitor();
  }, []);

  const getVisitor = () => {
    axios.put("https://05uebzxorc.execute-api.ap-northeast-1.amazonaws.com/cloud_resume_stage/countVisitor")
    .then((res) => {
      const updatedContacts = [...CVData.personalData.contacts];
      updatedContacts[4] = { ...updatedContacts[4], value: "visitors: " + res.data };
      console.log(res)
      setCvData(prevData => ({
        ...prevData,
        personalData: {
          ...prevData.personalData,
          contacts: updatedContacts,
        }
      }));
    })
    .catch((err) => {
      console.log(err)

    })
  }

  // console.log(cvData.personalData)

  return (
    <ReactCV
      {...cvData}
      branding={false}
    />
  );
};

const container = document.getElementById('app');
const root = createRoot(container)
root.render(<App />);