import 'https://code.jquery.com/jquery-3.6.0.min.js';
import '/socket.io/socket.io.js'


const socket = io("http://localhost:3000");
socket.on("connect", () => {
    console.log(socket.connected); // true
});

socket.on("disconnect", () => {
    console.log(socket.connected); // false
});

class App {
    static setUser(user) {
        localStorage.setItem('user', user);
        this.setState({
            user: user
        });
    }

    static setRegister(value){
        this.setState({
            isRegister: true
        })
    }

    static main = $('#app');
    static state = {
        isRegister: false,
        id: 0,
        user: localStorage.getItem('user')
    }
    static setState(state) {
        this.state = {
            // ...this.state,
            ...state
        }
        this.render();
    }

    static render() {
        this.main.html(Main(this));
    }

}

App.render();

function Main() {
    let main = $(`<div></div>`)
    let login = $(`
        <div class="d-flex justify-content-center bg-secondary vh-100">
            <div class="" style="width:360px">
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-header">   
                                <h3>Login</h3>
                            </div>
                            <div class="card-body">
                                
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <input type="email" class="form-control" id="email" placeholder="Enter email">
                                    </div>
                                    <div class="form-group">
                                        <label for="password">Password</label>
                                        <input type="password" class="form-control" id="password" placeholder="Password">
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <button id="submit" class="btn btn-primary mt-4 center">Submit</button>
                                        <div id="register" style="cursor: pointer;" class="text-primary mt-4 center">Register</div>
                                    </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `);

    let register = $(`
        <div class="d-flex justify-content-start bg-secondary vh-100">
            <div class="" >
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-header">   
                                <h3>Register</h3>
                            </div>
                            <div class="card-body ">
                                    <div class="form-group p-2">

                                        <input type="text" class="form-control" id="r_name" placeholder="Enter Name">
                                    </div>
                                    <div class="form-group p-2">

                                        <input type="email" class="form-control" id="r_email" placeholder="Enter email">
                                    </div>
                                    <div class="form-group p-2">

                                        <input type="password" class="form-control" id="r_password" placeholder="Password">
                                    </div>
                                    <div class="d-flex justify-content-between p-2">
                                        <button id="r_submit" class="btn btn-primary mt-4 ">Submit</button>
                                    </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `)

    
    
    login.find('#register').on('click', () => {
        App.setRegister(true)
    })

    

    let email = login.find('#email');
    let password = login.find('#password');
    let submit = login.find('#submit');

    submit.on('click', () => {
        let data = {
            email: email.val(),
            password: password.val()
        }

        $.post('/login', data, ).then((data)=> {
            console.log(data)
        }).catch(e => {
            Swal.fire(
                `error`
            )
        })


        // $.ajax({
        //     url: '/login',
        //     method: 'POST',
        //     data: data,
        //     statusCode: {
        //         "": () => {
        //             console.log("404")
        //         }
        //     },
        //     success: (data) => {
                
        //        console.log(data);
        //     }
        // })
    });

    let sudahLogin = $(`
        <div class="d-flex justify-content-center bg-secondary vh-100">
            <div class="" style="width:360px">
                ${App.state.user == null}
                <h1>sudah login ${App.state.id}</h1>
                <button id="logout">logout</button>
            </div>
        </div>

    `)

    sudahLogin.find('#logout').on('click', () => {
        localStorage.removeItem('user');
        App.setUser("{}");
    })

    main = App.state.isRegister? register: login;

    return main ;

}



// var nom = 0;
// sse.addEventListener("coba", function (e) {
//     console.log(e.data);
//     nom++;

//     // MyApp.setState({ id: nom });

// })



// const App = function _App() {
//     return `
//           <h1>Hello Vanilla JS!</h1>
//           <div>
//             Example of state management in Vanilla JS
//           </div>
//           <br />
//           <h1>${App.state.count}</h1>
//           <button id="button">Increase</button>
//         `;
// };

// App.state = {
//     count: 0,
//     increment: () => {
//         setState(() => App.state.count++);
//     }
// };

// const setState = (callback) => {
//     callback();
//     $('#app').html(App());
// }

// $('#app').html(App());

// sse.addEventListener("coba", function (e) {
//     console.log(e.data);
//     App.state.increment()
// })







