import logo from './../images/logo.svg';
import { NavMenu } from './NavMenu';
import './App.css';

function App() {
  return (
    <div className="App">
      <NavMenu/>
      <header className="App-header">
        <img src={logo} alt="logo" />
      </header>
    </div>
  );
}

export default App;
