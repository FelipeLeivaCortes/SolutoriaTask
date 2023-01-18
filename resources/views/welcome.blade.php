<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Laravel</title>

        <!-- Styles -->
        <link href="{{ asset('css/app.css') }}" rel="stylesheet">
        <link href="{{ asset('css/custom.css') }}" rel="stylesheet">

        <!-- Scripts -->
        <script src="{{ asset('js/app.js') }}" defer></script>
        <script src="https://code.jquery.com/jquery-3.6.3.slim.min.js" integrity="sha256-ZwqZIVdD3iXNyGHbSYdsmWP//UBokj2FHAxKuSBKDSo=" crossorigin="anonymous"></script>
        <script src="{{ asset('js/custom.js') }}"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>

    <body class="antialiased">

        <!-- Required to show events in a modal -->
        @include('alerts')



        <div class="container" id="root">
            <!-- Title -->
            <section class="mt-5">
                <h2 class="d-flex justify-content-center">
                    Bienvenido al sistema para postulación a <i>Solutoria Task</i>
                </h2>

                <p class="mt-5">Para obtener los resultados, siga los siguientes pasos que se describen a continuación</p>
            </section>


            <!-- Upload data to database -->
            <section class="my-5">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">
                            <h4>Cargar Datos</h4>
                            <p>Si la base de datos no tiene información, puede solicitarla ingresando su usuario en el siguiente campo.</p>
                            <small><b>* Nota:</b> Su usuario es el correo entregado por la institución</small>
                        </div>
                    </div>

                    {!! Form::open(['route' => 'downloadData']) !!}
                        @csrf    
                    
                        <div class="card-body">    
                            <div class="form-group">
                                <label for="username" class="form-label">Usuario</label>
                                <input type="text" id="username" name="username" class="form-control" placeholder="Ingrese su usuario" value="felipeleivacortes1995843_tkp@indeedemail.com" required>
                            </div>
                        </div>

                        <div class="card-footer">
                            <button type="submit" class="btn btn-primary" id="requestDataBtn">Solicitar</button>
                        </div>
                    {!! Form::close() !!}
                </div>
            </section>


            <!-- If exists data show this section -->
            @if ( $items > 0 )
                <section class="my-5">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">
                                <h4>Filtrar Datos</h4>
                                <p>Su base de datos cuenta con registros, ahora puede filtrarlos por fechas.</p>
                            </div>
                        </div>

                        {!! Form::open(['route' => 'getData']) !!}
                            @csrf
                            <div class="card-body">
                                <div class="row">
                                    <div class="form-group col">
                                        <label for="dateStart">Fecha Inicio</label>
                                        <input type="date" name="dateStart" id="dateStart" class="form-control" value="2021-12-29" required>
                                    </div>
                                    <div class="form-group col">
                                        <label for="dateEnd">Fecha Termino</label>
                                        <input type="date" name="dateEnd" id="dateEnd" class="form-control" value="2021-12-31" required>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <button class="btn btn-primary mr-2">Buscar</button>
                                <a href="{{ route('data.index') }}" class="btn btn-primary">Administrar Datos</a>
                            </div>
                        {!! Form::close() !!}
                    </div>
                </section>
            @endif


            @if ( isset($data) )
                <section>
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">
                                <h4>Mostrando Resultados</h4>
                            </div>
                        </div>
                        <div class="card-body">
                            <canvas id="myChart"></canvas>
                        </div>
                    </div>
                </section>

                <script>
                    createChart(<?=$data?>);
                </script>
            @endif
        </div>
    </body>
</html>
