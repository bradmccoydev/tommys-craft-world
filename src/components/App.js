import logo from './../images/logo.svg';
import ReactGA from 'react-ga';
import { NavMenu } from './NavMenu';
import './App.css';
ReactGA.initialize('G-3Z24N911N4');
ReactGA.pageview(window.location.pathname);

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
