// CustomFileUpload.tsx
import React, { useState, ChangeEvent } from "react";

interface CustomFileUploadProps {
  onChange: (file: File | null) => void;
}

const CustomFileUpload: React.FC<CustomFileUploadProps> = ({ onChange }) => {
  const [selectedFile, setSelectedFile] = useState<File | null>(null);

  const handleFileChange = (e: ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files && e.target.files[0];
    setSelectedFile(file);
    onChange(file); // Pass the selected file to the parent component
  };

  return (
    <div>
      <input type="file" onChange={handleFileChange} />
      {selectedFile && <p>Selected File: {selectedFile.name}</p>}
    </div>
  );
};

export default CustomFileUpload;
