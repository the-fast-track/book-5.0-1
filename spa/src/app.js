import '../assets/css/app.scss';

import {h, render} from 'preact';
import {Router, Link} from 'preact-router';

import Home from './pages/home';
import Conference from './pages/conference';

function App() {
    return (
        <div>
            <header className="header">
                <nav className="navbar navbar-light bg-light">
                    <div className="container">
                        <Link className="navbar-brand mr-4 pr-2" href="/">
                            &#128217; Guestbook
                        </Link>
                    </div>
                </nav>

                <nav className="bg-light border-bottom text-center">
                    <Link className="nav-conference" href="/conference/amsterdam2019">
                        Amsterdam 2019
                    </Link>
                </nav>
            </header>

            <Router>
                <Home path="/" />
                <Conference path="/conference/:slug" />
            </Router>
        </div>
    )
}

render(<App />, document.getElementById('app'));
