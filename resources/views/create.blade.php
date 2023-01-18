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
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>

    <body class="antialiased">

        <!-- Required to show events in a modal -->
        @include('alerts')



        <div class="container" id="root">
            <!-- Title -->
            <section class="mt-5">
                <h2 class="d-flex justify-content-center">
                    Registrar Movimiento
                </h2>

                <p class="mt-5">En esta sección podrás registrar un movimiento nuevo.</p>
            </section>

            
            <section class="my-5">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">
                            <h4>Registrar Movimiento</h4>
                        </div>
                    </div>

                    {!! Form::open(['route' => 'data.store']) !!}
                        <div class="card-body">
                            @include('partials.form')
                        </div>
                        
                        <div class="card-footer">
                            <button type="submit" class="btn btn-primary">Registrar</button>
                            <a href="{{route('data.index')}}" class="btn btn-danger">Volver</a>
                        </div>
                    {!! Form::close() !!}
                </div>
            </section>
        </div>
    </body>
</html>
