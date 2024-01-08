// import React from "react";
// import ReactDOM from "react-dom/client";
// import { BrowserRouter, Routes, Route } from "react-router-dom";
// import { UserProvider } from "./context/UserContext.tsx";
// import LogIn from "./pages/login/Login";
// import RegisterGym from "./pages/register/Register";
// import Home from "./pages/home/Home.tsx";
// import Users from "./pages/users/Users.tsx";
// import User from "./pages/user/User.tsx";
// import App from "./App.tsx";
// import Posts from "./pages/posts/Posts.tsx";
// import Post from "./pages/post/Post.tsx";

// ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
//   <React.StrictMode>
//     <BrowserRouter>
//       <UserProvider>
//         <Routes>
//           <Route path="/login" element={<LogIn />} />
//           <Route path="/register" element={<RegisterGym />} />
//           <Route path="/" element={<App />}>
//             <Route index element={<Home />} />
//             <Route path="/users" element={<Users />} />
//             <Route path="/users/:id" element={<User />} />
//             <Route path="/posts" element={<Posts />} />
//             <Route path="/post/:id" element={<Post />} />
//           </Route>
//         </Routes>
//       </UserProvider>
//     </BrowserRouter>
//   </React.StrictMode>
// );
import { UserProvider } from "./context/UserContext.tsx";
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.tsx";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import LogIn from "./pages/login/Login.tsx";
import RegisterGym from "./pages/register/Register.tsx";
import Home from "./pages/home/Home.tsx";
import Users from "./pages/users/Users.tsx";
import User from "./pages/user/User.tsx";
import Posts from "./pages/posts/Posts.tsx";
import Post from "./pages/post/Post.tsx";

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
  <React.StrictMode>
    <BrowserRouter>
      <UserProvider>
        <Routes>
          <Route path="/login" element={<LogIn />} />
          <Route path="/register" element={<RegisterGym />} />
          <Route path="/" element={<App />}>
            <Route index element={<Home />} />
            <Route path="/users" element={<Users />} />
            <Route path="/users/:id" element={<User />} />
            <Route path="/posts" element={<Posts />} />
            <Route path="/post/:id" element={<Post />} />
          </Route>
        </Routes>
      </UserProvider>
    </BrowserRouter>
  </React.StrictMode>
);
